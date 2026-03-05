import 'package:meta/meta.dart';
import 'package:mdtestapp/model/response/response_success.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final ResponseSuccess? responseData;
  RegisterSuccess({required this.responseData});
}

class RegisterError extends RegisterState {
  final String? errorMessage;
  RegisterError({this.errorMessage});
}
