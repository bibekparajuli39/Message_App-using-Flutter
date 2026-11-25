import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:message_app/core/constant/theme/app_color.dart';
import 'package:message_app/core/routes/routes.dart';
import 'package:message_app/core/widgets/buttom.dart';
import 'package:message_app/features/auth/bloc/auth_bloc.dart';
import 'package:message_app/features/auth/bloc/auth_event.dart';
import 'package:message_app/features/auth/bloc/auth_state.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAF9FF),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.go(Routes.login);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                content: Text('Password reset email sent successfully!'),
              ),
            );
          }
          if (state is PasswordResetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1ECFF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 55,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    SizedBox(height: 30),

                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Don\'t worry! Enter your email address '
                      'and we will send you a link to reset '
                      'your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 35),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your registered email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(value.trim())) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),

                    Buttom(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            EmailForget(email: emailController.text.trim()),
                          );
                        }
                      },
                      text: 'Send Reset Link',
                      isLoading: state is PasswordResetLoading,
                    ),

                    SizedBox(height: 25),

                    TextButton(
                      onPressed: () {
                        context.go(Routes.login);
                      },
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
