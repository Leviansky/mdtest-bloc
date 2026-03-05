// ignore_for_file: depend_on_referenced_packages

import 'package:meta/meta.dart';
import 'package:mdtestapp/model/account/auth/request/request_auth.dart';

@immutable
abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final dynamic apiToken;
  final RequestAuth request;

  AuthLogin({required this.apiToken, required this.request});
}

class AuthLogout extends AuthEvent {}

class AuthResendVerification extends AuthEvent {
  final dynamic apiToken;
  AuthResendVerification(this.apiToken);
}
