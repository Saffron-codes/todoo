import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initSupabase() async {
  String supabaseUrl = "https://gffrsyusillsqgtrrgif.supabase.co";
  String anonKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmZnJzeXVzaWxsc3FndHJyZ2lmIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjAzMTY2MzUsImV4cCI6MTk3NTg5MjYzNX0.dQPFy2ucExl8GsZLiFW7mkL4HN5pvCyVQZ4fzmmOQ5g";
  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
}
