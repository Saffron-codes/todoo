import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_supabase/core/viewmodels/auth_page_viewmodel.dart';
import 'package:todolist_supabase/core/viewmodels/auth_viewmodel.dart';
import 'package:todolist_supabase/presentation/all_todos/all_todos_view.dart';
import 'package:todolist_supabase/presentation/login/login_view.dart';
import 'package:todolist_supabase/presentation/signup/signup_view.dart';
import 'package:todolist_supabase/presentation/welcome/welcome_view.dart';

class DeceiderView extends StatefulWidget {
  const DeceiderView({super.key});

  @override
  State<DeceiderView> createState() => _DeceiderViewState();
}

class _DeceiderViewState extends State<DeceiderView> {
  final supabase = Supabase.instance.client;
  late User? _user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() async {
    if (supabase.auth.currentUser != null) {
      supabase.auth.refreshSession();
      print(supabase.auth.currentUser);
      _user = supabase.auth.currentUser;
    } else {
      _user = null;
      print('No User');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user != null) {
      return AllTodosView();
    } else {
      return provider.ChangeNotifierProvider(
        create: (context) => AuthPageViewModel(),
        child: WelcomeView(),
      );
    }
  }
}

class AuthPageView extends StatefulWidget {
  const AuthPageView({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthPageView> createState() => _AuthPageViewState();
}

class _AuthPageViewState extends State<AuthPageView> {
  @override
  Widget build(BuildContext context) {
    AuthPageViewModel _authPageViewModel =
        provider.Provider.of<AuthPageViewModel>(context);
    return PageView(
      controller: _authPageViewModel.authPageController,
      children: [
        LoginView(),
        SignupView(),
      ],
    );
  }
}

