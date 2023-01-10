import 'package:flutter/material.dart';
import 'package:todolist_supabase/app.dart';
import 'package:todolist_supabase/injection_container.dart' as di;
import 'package:todolist_supabase/supabase_client.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  await di.init();
  runApp(App());
}




