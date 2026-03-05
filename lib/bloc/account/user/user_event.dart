// ignore_for_file: depend_on_referenced_packages

import 'package:meta/meta.dart';

@immutable
abstract class UserEvent {}

class UserLoadHome extends UserEvent {}

class UserSearch extends UserEvent {
  final String query;

  UserSearch({required this.query});
}

class UserFilter extends UserEvent {
  final String filter;

  UserFilter({required this.filter});
}

class UserRefreshVerification extends UserEvent {}
