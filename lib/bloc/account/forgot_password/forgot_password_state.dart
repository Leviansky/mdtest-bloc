import 'package:meta/meta.dart';
import 'package:mdtestapp/model/response/response_success.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ResponseSuccess? responseData;

  ForgotPasswordSuccess({this.responseData});
}

class ForgotPasswordError extends ForgotPasswordState {
  final String? errorMessage;

  ForgotPasswordError({this.errorMessage});
}
