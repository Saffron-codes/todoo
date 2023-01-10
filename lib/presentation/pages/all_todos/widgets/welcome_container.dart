import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/injection_container.dart';

class WelcomeContainer extends StatelessWidget {
  final supabase = sl<SupabaseClient>();

   WelcomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hey 👋 ${supabase.auth.currentUser!.userMetadata!['username']}"),
          TextButton(onPressed: ()=>Navigator.pushNamed(context, '/create'), child: Text('Add a new Todo'))
        ],
      ),
    );
  }
}