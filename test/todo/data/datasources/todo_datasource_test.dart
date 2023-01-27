import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/data/data_sources/todo/todo_data_source.dart';
import 'package:todolist_supabase/data/models/todo/todo_model.dart';
import './todo_datasource_test.mocks.dart';
// class MockSupabaseClient extends Mock implements SupabaseClient {}

@GenerateMocks([TodoRemoteDataSourceImpl, TodoModel])
void main() {
  group('todo crud operations', () {
    test('deletes a todo', () async {
      // final supabaseClient = MockSupabaseClient();
      final todoDataSource = MockTodoRemoteDataSourceImpl();

      when(todoDataSource.deleteTodo('id'))
          .thenAnswer((_) async => MockTodoModel());

      expect(await todoDataSource.deleteTodo('id'), isA<MockTodoModel>());
    });

    test('creates a todo', () async {
      // final supabaseClient = MockSupabaseClient();
      final todoDataSource = MockTodoRemoteDataSourceImpl();

      when(todoDataSource.insertTodo('content'))
          .thenAnswer((_) async => MockTodoModel());

      expect(await todoDataSource.insertTodo('content'), isA<MockTodoModel>());
    });

    test('check todo', () async {
      // final supabaseClient = MockSupabaseClient();
      final todoDataSource = MockTodoRemoteDataSourceImpl();

      when(todoDataSource.checkTodo('id', false))
          .thenAnswer((_) async => MockTodoModel());

      expect(await todoDataSource.checkTodo('id', false), isA<MockTodoModel>());
    });

    // test('throws an exception if the http call completes with an error', () {
    //   final todoDataSource = MockTodoRemoteDataSourceImpl();

    //   // Use Mockito to return an unsuccessful response when it calls the
    //   // provided http.Client.
    //   when(todoDataSource.insertTodo('content')).thenAnswer((_)async => throwsException);

    //   expect(fetchAlbum(client), throwsException);
    // });
  });
}
