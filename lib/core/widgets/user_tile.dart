import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: ClipRRect(
        child: ListTile(
          leading: CircleAvatar(radius: 26, child: Icon(Icons.person)),
          title: Text('Name'),
          trailing: Text('seen'),
          subtitle: Text('hi,how r u?'),
        ),
      ),
    );
  }
}
