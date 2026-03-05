import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdtestapp/library/app_log.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_route);
  }

  Future<void> _route() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    appPrint("user: $user");

    if (user == null) {
      Get.offAllNamed('/login');
      return;
    }

    await user.reload();
    final refreshedUser = auth.currentUser;

    final isVerified = refreshedUser?.emailVerified ?? false;
    appPrint("emailVerified: $isVerified");

    if (refreshedUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(refreshedUser.uid)
          .set({"isEmailVerified": isVerified}, SetOptions(merge: true));
    }

    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
