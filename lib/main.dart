import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mdtestapp/bloc/account/auth/bloc.dart';
import 'package:mdtestapp/bloc/account/forgot_password/forgot_password_bloc.dart';
import 'package:mdtestapp/bloc/account/register/register_bloc.dart';
import 'package:mdtestapp/bloc/account/user/user_bloc.dart';
import 'package:mdtestapp/firebase_options.dart';
import 'package:mdtestapp/ui/authentication/login_page.dart';
import 'package:mdtestapp/ui/forgot_password/forgot_password_page.dart';
import 'package:mdtestapp/ui/home/home_page.dart';
import 'package:mdtestapp/ui/register/register_page.dart';
import 'package:mdtestapp/ui/splash_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),
        BlocProvider<ForgotPasswordBloc>(create: (_) => ForgotPasswordBloc()),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
      ],
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "MDTEST APP",
        theme: ThemeData(primaryColor: Colors.blue),
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreenPage()),
          GetPage(name: '/login', page: () => LoginPage()),
          GetPage(name: '/register', page: () => RegisterPage()),
          GetPage(name: '/forgot-password', page: () => ForgotPasswordPage()),
          GetPage(name: '/home', page: () => HomePage()),
        ],
      ),
    );
  }
}
