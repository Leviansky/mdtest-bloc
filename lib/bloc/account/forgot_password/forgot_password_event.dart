import 'package:meta/meta.dart';

@immutable
abstract class ForgotPasswordEvent {}

class ForgotPasswordSubmit extends ForgotPasswordEvent {
  final dynamic apiToken;
  final String email;

  ForgotPasswordSubmit({required this.apiToken, required this.email});
}
