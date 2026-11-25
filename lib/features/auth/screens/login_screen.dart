import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:message_app/core/constant/theme/app_color.dart';
import 'package:message_app/core/routes/routes.dart';
import 'package:message_app/core/widgets/buttom.dart';
import 'package:message_app/features/auth/bloc/auth_bloc.dart';
import 'package:message_app/features/auth/bloc/auth_event.dart';
import 'package:message_app/features/auth/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: height,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticate) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green.shade600,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                  content: Text('Successfully logged in'),
                ),
              );

              context.go(Routes.home);
            }

            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.message.toString()),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  height: height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 100, left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome User',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'Enjoy the Journey',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: height * 0.25,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFAF9FF),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Form(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                            ),

                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter your Email',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),

                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                            ),

                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter your Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                                suffixIcon: Icon(Icons.remove_red_eye),
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  context.go(Routes.forget);
                                },
                                child: Text('Forgot Password?'),
                              ),
                            ),

                            Center(
                              child: Buttom(
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                    EmailLogin(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                },
                                text: 'Login',
                                isLoading: state is AuthLoading,
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Divider(height: 1, thickness: 1),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Or Continue With',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(height: 1, thickness: 1),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: state is AuthLoading
                                        ? null
                                        : () {},
                                    icon: Image.network(
                                      'https://www.google.com/favicon.ico',
                                      height: 20,
                                      width: 20,
                                    ),
                                    label: Text('Google'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 12),

                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: state is AuthLoading
                                        ? null
                                        : () {},
                                    icon: Icon(
                                      Icons.facebook,
                                      color: Colors.blue,
                                      size: 23,
                                    ),
                                    label: Text('Facebook'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 100, left: 20),
                              child: Row(
                                spacing: 5,
                                children: [
                                  Text("Don't have an account?"),
                                  InkWell(
                                    onTap: () {
                                      context.go(Routes.signup);
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
