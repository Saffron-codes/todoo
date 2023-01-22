import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_supabase/presentation/pages/app_views.dart';

import '../../../core/services/dialog_service.dart';
import '../../../core/services/toast_service.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/internet_bloc/internet_bloc.dart';

class DeceiderView extends StatelessWidget {
  final dialogService = DialogService();
  final toastService = ToastService();
  DeceiderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetDisconnected) {
          toastService.errorToast(message: "Check your Internet Connection");
        }
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Loading) {
            dialogService.showLoadingDialog(context: context);
          } else if (state is DismissDialog) {
            dialogService.closeDialog(context: context);
          } else if (state is AuthError) {
            toastService.errorToast(message: state.message);
          }
        },
        builder: (context, state) {
          if (state is Uninitialized) {
            return Scaffold();
          } else if (state is Authenticated) {
            return AllTodosView();
          } else if (state is Unauthenticated) {
            return LoginView();
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
