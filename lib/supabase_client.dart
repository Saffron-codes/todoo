import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initSupabase() async {
  await dotenv.load(fileName: ".env");
  String? supabaseUrl = dotenv.env['SUPABASE_URL'];
  String? anonKey = dotenv.env['SUPABASE_ANON_KEY'];
  try{
  await Supabase.initialize(
    url: supabaseUrl.toString(),
    anonKey: anonKey.toString(),
  );
  } catch (e){
    print("Supabase initialization Failed");
  }
}
