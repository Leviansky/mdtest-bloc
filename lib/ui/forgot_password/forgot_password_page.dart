import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:mdtestapp/bloc/account/forgot_password/forgot_password_bloc.dart';
import 'package:mdtestapp/bloc/account/forgot_password/forgot_password_event.dart';
import 'package:mdtestapp/bloc/account/forgot_password/forgot_password_state.dart';
import 'package:mdtestapp/utils/general_function.dart';
import 'package:mdtestapp/widgets/global/app_snackbar.dart';

// Global widgets
import 'package:mdtestapp/widgets/global/button.dart';
import 'package:mdtestapp/widgets/global/padding.dart';
import 'package:mdtestapp/widgets/global/text_field.dart';

// Reusable widgets
import 'package:mdtestapp/widgets/reusable/re_auth_card.dart';
import 'package:mdtestapp/widgets/reusable/re_auth_header.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  void handleForgotPassword() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      AppSnackbar.show(
        context,
        message: "Please enter your email address",
        type: AppSnackType.error,
      );
      return;
    }

    if (!isValidEmail(email)) {
      AppSnackbar.show(
        context,
        message: "Please enter a valid email address",
        type: AppSnackType.error,
      );
      return;
    }

    context.read<ForgotPasswordBloc>().add(
      ForgotPasswordSubmit(apiToken: null, email: email),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F9FF);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              AppSnackbar.show(
                context,
                message:
                    "If the email is registered, a reset link has been sent.",
                type: AppSnackType.success,
              );
            }

            if (state is ForgotPasswordError) {
              AppSnackbar.show(
                context,
                message: state.errorMessage ?? "Error",
                type: AppSnackType.error,
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is ForgotPasswordLoading;

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
                          title: "Reset password",
                          subtitle: "We’ll send a reset link to your email",
                          icon: Icons.mark_email_unread_outlined,
                        ),
                        GPaddings.v18,
                        GTextField(
                          controller: emailController,
                          label: "Email",
                          hint: "you@example.com",
                          prefixIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                        ),
                        GPaddings.v18,
                        GPrimaryButton(
                          label: "Send Reset Email",
                          loading: isLoading,
                          onPressed: isLoading ? null : handleForgotPassword,
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
