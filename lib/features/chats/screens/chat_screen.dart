import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:message_app/core/constant/theme/app_color.dart';
import 'package:message_app/core/routes/routes.dart';
import 'package:message_app/core/widgets/user_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Chat App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: .bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),

      body: InkWell(
        onTap: () {
          context.go(Routes.user);
        },
        child: UserTile(),
      ),
    );
  }
}
