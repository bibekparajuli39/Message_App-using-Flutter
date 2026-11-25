import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:message_app/core/constant/theme/app_color.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: AppColor.primaryColor,
        title: Text('Name', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
