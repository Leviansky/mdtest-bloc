// ignore_for_file: depend_on_referenced_packages

import 'package:mdtestapp/model/user_app.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final String name;
  final String email;
  final bool verified;
  final List<UserApp> users;

  UserSuccess({
    required this.name,
    required this.email,
    required this.verified,
    required this.users,
  });
}

class UserError extends UserState {
  final String? errorMessage;

  UserError({this.errorMessage});
}
