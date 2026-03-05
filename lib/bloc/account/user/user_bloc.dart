import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mdtestapp/library/app_log.dart';
import 'package:mdtestapp/model/user_app.dart';
import 'package:mdtestapp/utils/general_function.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserApp> allUsers = [];

  UserBloc() : super(UserInitial()) {
    on<UserLoadHome>(_loadHome);
    on<UserSearch>(_searchUser);
    on<UserFilter>(_filterUser);
    on<UserRefreshVerification>(_refreshVerification);
  }

  Future<void> _loadHome(UserLoadHome event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final user = _auth.currentUser;

      if (user == null) {
        emit(UserError(errorMessage: "User not logged in"));
        return;
      }

      final snapshot = await _firestore.collection("users").get();

      allUsers = snapshot.docs.map((e) {
        return UserApp.fromFirestore(e.id, e.data());
      }).toList();

      appPrint(allUsers);

      emit(
        UserSuccess(
          name: user.displayName ?? "",
          email: user.email ?? "",
          verified: user.emailVerified,
          users: allUsers,
        ),
      );
    } catch (ex) {
      emit(UserError(errorMessage: replaceException(ex.toString())));
    }
  }

  Future<void> _searchUser(UserSearch event, Emitter<UserState> emit) async {
    if (state is! UserSuccess) return;

    final current = state as UserSuccess;

    final filtered = allUsers.where((u) {
      return u.name.toLowerCase().contains(event.query.toLowerCase()) ||
          u.email.toLowerCase().contains(event.query.toLowerCase());
    }).toList();

    emit(
      UserSuccess(
        name: current.name,
        email: current.email,
        verified: current.verified,
        users: filtered,
      ),
    );
  }

  Future<void> _filterUser(UserFilter event, Emitter<UserState> emit) async {
    if (state is! UserSuccess) return;

    final current = state as UserSuccess;

    List<UserApp> filtered = [];

    if (event.filter == "verified") {
      filtered = allUsers.where((u) => u.isEmailVerified).toList();
    } else if (event.filter == "not_verified") {
      filtered = allUsers.where((u) => !u.isEmailVerified).toList();
    } else {
      filtered = allUsers;
    }

    emit(
      UserSuccess(
        name: current.name,
        email: current.email,
        verified: current.verified,
        users: filtered,
      ),
    );
  }

  Future<void> _refreshVerification(
    UserRefreshVerification event,
    Emitter<UserState> emit,
  ) async {
    try {
      final user = _auth.currentUser;

      if (user == null) return;

      await user.reload();
      final refreshedUser = _auth.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        await _firestore.collection("users").doc(refreshedUser.uid).update({
          "isEmailVerified": true,
        });
      }

      add(UserLoadHome());
    } catch (e) {
      emit(UserError(errorMessage: e.toString()));
    }
  }
}
