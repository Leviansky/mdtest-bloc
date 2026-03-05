import 'package:meta/meta.dart';
import 'package:mdtestapp/model/account/auth/request/request_auth.dart';

@immutable
abstract class RegisterEvent {}

class RegisterSubmit extends RegisterEvent {
  final dynamic apiToken;
  final RequestAuth request;

  RegisterSubmit({required this.apiToken, required this.request});
}
