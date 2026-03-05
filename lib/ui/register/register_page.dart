import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:mdtestapp/bloc/account/register/register_bloc.dart';
import 'package:mdtestapp/bloc/account/register/register_event.dart';
import 'package:mdtestapp/bloc/account/register/register_state.dart';
import 'package:mdtestapp/model/account/auth/request/request_auth.dart';
import 'package:mdtestapp/widgets/global/app_snackbar.dart';

// Global widgets
import 'package:mdtestapp/widgets/global/button.dart';
import 'package:mdtestapp/widgets/global/padding.dart';
import 'package:mdtestapp/widgets/global/text_field.dart';

// Reusable widgets
import 'package:mdtestapp/widgets/reusable/re_auth_card.dart';
import 'package:mdtestapp/widgets/reusable/re_auth_header.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void handleRegister() {
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      AppSnackbar.show(
        context,
        message: "Please fill in all required fields",
        type: AppSnackType.error,
      );
      return;
    }

    if (!email.contains("@")) {
      AppSnackbar.show(
        context,
        message: "Please enter a valid email address",
        type: AppSnackType.error,
      );
      return;
    }

    if (pass.length < 6) {
      AppSnackbar.show(
        context,
        message: "Password must be at least 6 characters",
        type: AppSnackType.error,
      );
      return;
    }

    if (pass != confirm) {
      AppSnackbar.show(
        context,
        message: "Passwords do not match",
        type: AppSnackType.error,
      );
      return;
    }

    final request = RequestAuth(email: email, password: pass);

    context.read<RegisterBloc>().add(
      RegisterSubmit(apiToken: null, request: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F9FF);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              AppSnackbar.show(
                context,
                message:
                    "Registration successful. Please check your email to verify your account.",
                type: AppSnackType.success,
              );
              Get.offAllNamed("/login");
            }

            if (state is RegisterError) {
              AppSnackbar.show(
                context,
                message: state.errorMessage ?? "Register gagal",
                type: AppSnackType.error,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is RegisterLoading;

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
                          title: "Create account",
                          subtitle: "Register to get started",
                          icon: Icons.person_add_alt_1_outlined,
                        ),
                        GPaddings.v18,
                        GTextField(
                          controller: emailController,
                          label: "Email",
                          hint: "you@example.com",
                          prefixIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        GPaddings.v12,
                        GTextField(
                          controller: passwordController,
                          label: "Password",
                          hint: "Min. 6 characters",
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                        ),
                        GPaddings.v12,
                        GTextField(
                          controller: confirmPasswordController,
                          label: "Confirm Password",
                          hint: "Re-enter password",
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                        ),
                        GPaddings.v18,
                        GPrimaryButton(
                          label: "Register",
                          loading: isLoading,
                          onPressed: isLoading ? null : handleRegister,
                        ),
                        GPaddings.v12,
                        Center(
                          child: GTextAction(
                            label: "Back to Login",
                            onPressed: () => Get.offAllNamed("/login"),
                            color: const Color(0xFF4B5563),
                          ),
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
