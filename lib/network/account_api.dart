// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mdtestapp/config/session_manager.dart';
import 'package:mdtestapp/library/app_log.dart';
import 'package:mdtestapp/model/account/auth/request/request_auth.dart';
import 'package:mdtestapp/model/response/response_success.dart';

class AccountProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SessionManager sessionManager = SessionManager();

  /// LOGIN
  Future<ResponseSuccess> login(
    apiToken, {
    @required RequestAuth? request,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: request!.email!,
        password: request.password!,
      );
      final user = credential.user;
      appPrint(user);

      if (user == null) {
        throw Exception("Login gagal");
      }

      await sessionManager.setSession("uid", user.uid);
      return ResponseSuccess(
        message: "Login success",
        status: true,
        uid: user.uid,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // REGISTER
  Future<ResponseSuccess> register(
    apiToken, {
    @required RequestAuth? request,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: request!.email!,
        password: request.password!,
      );

      final user = credential.user;

      if (user != null) {
        await user.sendEmailVerification();

        await _firestore.collection("users").doc(user.uid).set({
          "name": "",
          "email": user.email,
          "isEmailVerified": false,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }

      return ResponseSuccess(
        message: "Registration success. Please verify your email.",
        status: true,
        uid: user?.uid,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// FORGOT PASSWORD
  Future<ResponseSuccess> forgotPassword(
    apiToken, {
    @required String? email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email!);

      return ResponseSuccess(
        message: "Password reset email sent",
        status: true,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// CHECK EMAIL VERIFICATION
  Future<bool> checkEmailVerified() async {
    final user = _auth.currentUser;

    if (user == null) return false;

    await user.reload();

    final refreshedUser = _auth.currentUser;

    if (refreshedUser!.emailVerified) {
      await _firestore.collection("users").doc(refreshedUser.uid).update({
        "isEmailVerified": true,
      });
    }

    return refreshedUser.emailVerified;
  }

  /// RESEND EMAIL VERIFICATION
  Future<ResponseSuccess> resendEmailVerification(apiToken) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception("Session expired. Please sign in again.");
      }

      await user.reload();
      final refreshedUser = _auth.currentUser;

      if (refreshedUser?.emailVerified == true) {
        await _firestore.collection("users").doc(refreshedUser!.uid).set({
          "isEmailVerified": true,
        }, SetOptions(merge: true));

        return ResponseSuccess(
          message: "Your email is already verified.",
          status: true,
        );
      }

      await refreshedUser?.sendEmailVerification();

      return ResponseSuccess(
        message: "Verification email sent. Please check your inbox.",
        status: true,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    await sessionManager.clearAll();
  }
}
