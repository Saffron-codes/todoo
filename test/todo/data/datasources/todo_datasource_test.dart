import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/data/data_sources/todo/todo_data_source.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  TodoRemoteDataSourceImpl dataSource;
  MockSupabaseClient mockSupabaseClient;

  setUp((){
    mockSupabaseClient = MockSupabaseClient();
    dataSource = TodoRemoteDataSourceImpl(client: mockSupabaseClient);
  });

  
}