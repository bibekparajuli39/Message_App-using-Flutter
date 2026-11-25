import 'package:flutter/material.dart';
import 'package:message_app/features/users/screens/users_screen.dart';
import 'package:message_app/features/chats/screens/chat_screen.dart';
import 'package:message_app/features/profile/screens/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final List pages = [ChatScreen(), UserScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              currentIndex = value;
            });
          },

          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.group), label: 'User'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
