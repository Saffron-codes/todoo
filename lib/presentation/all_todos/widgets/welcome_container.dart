import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeContainer extends StatelessWidget {
  final supabase = Supabase.instance.client;

   WelcomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text("Hey 👋 ${supabase.auth.currentUser!.userMetadata!['username']}"),
          TextButton(onPressed: (){}, child: Text('Add a new Todo'))
        ],
      ),
    );
  }
}