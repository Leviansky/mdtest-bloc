import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:mdtestapp/bloc/account/auth/auth_bloc.dart';
import 'package:mdtestapp/bloc/account/auth/auth_event.dart';
import 'package:mdtestapp/bloc/account/auth/auth_state.dart';
import 'package:mdtestapp/library/app_log.dart';
import 'package:mdtestapp/model/account/auth/request/request_auth.dart';
import 'package:mdtestapp/widgets/global/app_snackbar.dart';

// Global widgets
import 'package:mdtestapp/widgets/global/button.dart';
import 'package:mdtestapp/widgets/global/padding.dart';
import 'package:mdtestapp/widgets/global/text_field.dart';

// Reusable widgets
import 'package:mdtestapp/widgets/reusable/re_auth_actions.dart';
import 'package:mdtestapp/widgets/reusable/re_auth_card.dart';
import 'package:mdtestapp/widgets/reusable/re_auth_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthBloc _authBloc = AuthBloc();

  void handleLogin() {
    final request = RequestAuth(
      email: emailController.text,
      password: passwordController.text,
    );

    appPrint(request);
    _authBloc.add(AuthLogin(apiToken: null, request: request));
  }

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F9FF);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is AuthSuccess) {
              Get.offAllNamed("/home");
            }

            if (state is AuthError) {
              AppSnackbar.show(
                context,
                message: "Unable to sign in. Please try again.",
                type: AppSnackType.error,
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is AuthLoading;

            return Center(
              child: SingleChildScrollView(
                padding: GPaddings.page,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: ReAuthCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const ReAuthHeader(
                          title: "Welcome back",
                          subtitle: "Sign in to continue",
                          icon: Icons.lock_outline_rounded,
                        ),
                        GPaddings.v18,
                        GTextField(
                          controller: emailController,
                          label: "Email",
                          hint: "fikhazal@gmail.com",
                          prefixIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        GPaddings.v12,
                        GTextField(
                          controller: passwordController,
                          label: "Password",
                          hint: "••••••••",
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                        ),
                        GPaddings.v18,
                        GPrimaryButton(
                          label: "Login",
                          loading: isLoading,
                          onPressed: isLoading ? null : handleLogin,
                        ),
                        GPaddings.v12,
                        ReAuthActions(
                          onRegister: () => Get.toNamed("/register"),
                          onForgotPassword: () =>
                              Get.toNamed("/forgot-password"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
