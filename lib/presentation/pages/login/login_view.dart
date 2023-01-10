import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_supabase/core/services/dialog_service.dart';
import 'package:todolist_supabase/core/services/toast_service.dart';


import '../../bloc/login_bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  final dialogService = DialogService();

  final toastService = ToastService();

  void login(BuildContext context) {
    final isValidated = _loginFormKey.currentState!.validate();
    isValidated
        ? BlocProvider.of<LoginBloc>(context).add(
            LoginInButtonPressed(
                _emailController.text, _passwordController.text),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                dialogService.closeDialog(context: context);
                toastService.errorToast(message: "Login Error");
              } else if (state is LoginSuccess) {
                dialogService.closeDialog(context: context);
                toastService.successToast(message: "Login was Success");
              } else if (state is LoginLoading) {
                dialogService.showLoadingDialog(context: context);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Center(child: Text("Welcome Back! 👋")),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        } else if (!value.contains('@')) {
                          return "Enter a valid email";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        } else if (value.length < 6) {
                          return "Password should have 6 characters";
                        }
                      },
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      // onPressed: () => _authPageViewModel.NavigateToIndex(index: 1),
                      child: Text("Don't have a account ?  Signup"),
                    ),
                    ElevatedButton(
                      onPressed: () => login(context),
                      child: Text('Login', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 52)),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            )));
  }
}
