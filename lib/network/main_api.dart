// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:mdtestapp/config/session_manager.dart';

class ApiProvider {
  ApiProvider({required this.baseUrl, Dio? dio, SessionManager? session})
    : dio = dio ?? Dio(),
      session = session ?? SessionManager() {
    this.dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 25),
      headers: {'Content-Type': 'application/json'},
    );
  }

  final String baseUrl;
  final Dio dio;
  final SessionManager session;

  // Public helper (biar gampang dipakai di repo/service)
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
    bool withAuth = true,
  }) => _request<T>(
    'GET',
    path,
    query: query,
    cancelToken: cancelToken,
    withAuth: withAuth,
  );

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    bool withAuth = true,
  }) => _request<T>(
    'POST',
    path,
    data: data,
    cancelToken: cancelToken,
    withAuth: withAuth,
  );

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    bool withAuth = true,
  }) => _request<T>(
    'PUT',
    path,
    data: data,
    cancelToken: cancelToken,
    withAuth: withAuth,
  );

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    CancelToken? cancelToken,
    bool withAuth = true,
  }) => _request<T>(
    'DELETE',
    path,
    data: data,
    cancelToken: cancelToken,
    withAuth: withAuth,
  );

  Future<Response<T>> _request<T>(
    String method,
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
    bool withAuth = true,
  }) async {
    try {
      final headers = <String, dynamic>{};

      if (withAuth) {
        final token = await session.getSession("token"); // String? idealnya
        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      }

      final options = Options(method: method, headers: headers);

      final res = await dio.request<T>(
        path,
        data: data,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
      );

      return res;
    } on DioException catch (e) {
      // Auto refresh kalau 401 dan request butuh auth
      final status = e.response?.statusCode;
      final req = e.requestOptions;

      if (status == 401 && withAuth) {
        final refreshed = await _refreshToken();
        if (refreshed) {
          return _retry<T>(req);
        }
      }

      throw _mapDioError(e);
    }
  }

  Future<bool> _refreshToken() async {
    final refresh = await session.getSession("refreshToken"); // String?
    if (refresh == null || refresh.isEmpty) return false;

    try {
      final tmp = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 25),
          headers: {'Authorization': 'Bearer $refresh'},
        ),
      );

      final res = await tmp.get('/account/auth/refresh');

      final newToken = res.data?['data']?['access_token']?.toString();
      if (newToken == null || newToken.isEmpty) return false;

      await session.setSession("token", newToken);
      return true;
    } on DioException catch (e) {
      // refresh invalid -> clear session
      if (e.response?.statusCode == 401) {
        await session.clearLoginSession();
      }
      return false;
    }
  }

  Future<Response<T>> _retry<T>(RequestOptions requestOptions) async {
    final token = await session.getSession("token");
    final headers = Map<String, dynamic>.from(requestOptions.headers);

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    final options = Options(
      method: requestOptions.method,
      headers: headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      extra: requestOptions.extra,
      followRedirects: requestOptions.followRedirects,
      maxRedirects: requestOptions.maxRedirects,
      validateStatus: requestOptions.validateStatus,
    );

    return dio.request<T>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Exception _mapDioError(DioException e) {
    final status = e.response?.statusCode;
    final msg = e.response?.data?['message']?.toString();

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout. Please try again.');
    }

    if (e.type == DioExceptionType.cancel) {
      return Exception('Request cancelled');
    }

    if (status != null) {
      // Minimal mapping untuk assessment
      if (status >= 500) return Exception('Server error ($status)');
      if (status == 401) return Exception(msg ?? 'Unauthorized');
      if (status == 400) return Exception(msg ?? 'Bad request');
      if (status == 404) return Exception(msg ?? 'Not found');
      return Exception(msg ?? 'Request failed ($status)');
    }

    return Exception(e.message ?? 'Network error');
  }
}
