import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:message_app/core/constant/theme/app_color.dart';
import 'package:message_app/core/routes/routes.dart';
import 'package:message_app/core/widgets/buttom.dart';
import 'package:message_app/features/auth/bloc/auth_bloc.dart';
import 'package:message_app/features/auth/bloc/auth_event.dart';
import 'package:message_app/features/auth/bloc/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticate) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade600,
              behavior: SnackBarBehavior.floating,
              content: Text('Successfully created account'),
            ),
          );

          context.go(Routes.login);
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
        return Scaffold(
          body: SizedBox(
            height: height,
            child: Stack(
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
                          'Create Your Account',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'Create your account to explore',
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
                              'Name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                            ),

                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),

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
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: Icon(Icons.remove_red_eye),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),

                            Center(
                              child: Buttom(
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                    EmailSignUp(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                },
                                text: 'Sign Up',
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                              padding: EdgeInsets.only(top: 20, left: 20),
                              child: Row(
                                spacing: 5,
                                children: [
                                  Text('Already have an account?'),
                                  InkWell(
                                    onTap: () {
                                      context.go(Routes.login);
                                    },
                                    child: Text(
                                      'Sign in',
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
            ),
          ),
        );
      },
    );
  }
}
