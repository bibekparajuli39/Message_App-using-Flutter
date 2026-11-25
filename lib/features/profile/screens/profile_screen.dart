import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:message_app/core/constant/theme/app_color.dart';
import 'package:message_app/core/routes/routes.dart';
import 'package:message_app/core/widgets/buttom.dart';
import 'package:message_app/features/auth/bloc/auth_bloc.dart';
import 'package:message_app/features/auth/bloc/auth_event.dart';
import 'package:message_app/features/auth/bloc/auth_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: AppColor.backgroundColor,
              fontWeight: .bold,
            ),
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          debugPrint('Current Auth State: $state');
          if (state is AuthLogout) {
            debugPrint('Navigating to Login');
            context.go(Routes.login);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('LogOut failed'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is AuthAuthenticate) {
            final user = state.user;
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Color(0xFFF0EBFF),
                            backgroundImage: user.photoURL != null
                                ? NetworkImage(user.photoURL!)
                                : null,
                            child: user.photoURL == null
                                ? Icon(Icons.person)
                                : null,
                          ),
                          SizedBox(height: 10),
                          Text(
                            user.displayName.toString(),
                            style: TextStyle(fontWeight: .bold, fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Text(
                            user.email.toString(),
                            style: TextStyle(color: Colors.grey.shade900),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 130),
                            child: Buttom(
                              text: 'LogOut',
                              onTap: () {
                                context.read<AuthBloc>().add(EmailLogout());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: Text('Please login to view your profile'));
        },
      ),
    );
  }
}
