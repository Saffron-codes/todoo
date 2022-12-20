import 'package:flutter/material.dart';
import 'package:todolist_supabase/app.dart';
import 'package:todolist_supabase/core/locator.dart';
import 'package:todolist_supabase/supabase_client.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  setuplocator();
  runApp(App());
}




