// ignore_for_file: depend_on_referenced_packages

import 'package:mdtestapp/model/response/response_success.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final ResponseSuccess? responseData;
  AuthSuccess({@required this.responseData});
}

class AuthError extends AuthState {
  final String? errorMessage;
  AuthError({this.errorMessage});
}

class AuthActionSuccess extends AuthState {
  final ResponseSuccess responseData;
  AuthActionSuccess({required this.responseData});
}
