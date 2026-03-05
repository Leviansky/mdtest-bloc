import 'package:bloc/bloc.dart';
import 'package:mdtestapp/model/response/response_success.dart';
import 'package:mdtestapp/network/account_api.dart';
import 'package:mdtestapp/utils/general_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AccountProvider connect = AccountProvider();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>(_login);
    on<AuthLogout>(_logout);
    on<AuthResendVerification>(_resendVerification);
  }

  Future<void> _login(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      ResponseSuccess data = await connect.login(
        event.apiToken,
        request: event.request,
      );

      emit(AuthSuccess(responseData: data));
    } catch (ex) {
      emit(AuthError(errorMessage: replaceException(ex.toString())));
    }
  }

  Future<void> _logout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _auth.signOut();
      emit(AuthInitial());
    } catch (ex) {
      emit(AuthError(errorMessage: replaceException(ex.toString())));
    }
  }

  Future<void> _resendVerification(
    AuthResendVerification event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final data = await connect.resendEmailVerification(event.apiToken);

      emit(AuthSuccess(responseData: data));
    } catch (ex) {
      emit(AuthError(errorMessage: replaceException(ex.toString())));
    }
  }
}
