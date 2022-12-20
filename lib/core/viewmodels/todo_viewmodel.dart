import 'package:flutter/foundation.dart';
import 'package:todolist_supabase/core/services/toast_service.dart';
import 'package:todolist_supabase/core/services/todo_service.dart';

class TodoViewModel extends ChangeNotifier {
  bool _isCompletedViewMode = false;
  bool get isCompletedViewMode => _isCompletedViewMode;
  TodosService _todosService = TodosService();
  ToastService _toastService = ToastService();
  set setisCompletedViewMode(bool val) {
    _isCompletedViewMode = val;
    notifyListeners();
  }

  Future checkTodo({required String id, required bool? value}) async {
    try {
      await _todosService.checkTodo(id: id, value: value);
      if (value != null && value == true) {
        _toastService.successToast(message: 'Added to Completed List');
      } else {
        _toastService.successToast(message: 'Added to not Completed List');
      }
    } catch (e) {
      _toastService.errorToast(message: 'Some error occurred');
    }
  }

  Future deleteTodo({required String id}) async {
    try {
      await _todosService.deleteTodo(id: id);
      _toastService.successToast(message: 'Deleted Successfully');
    } catch (e) {
      _toastService.errorToast(message: 'Some error occurred');
    }
  }
}
