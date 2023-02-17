import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_supabase/core/services/authentication_service.dart';
import 'package:todolist_supabase/core/viewmodels/auth_page_viewmodel.dart';
import 'package:todolist_supabase/core/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart' as provider;
import 'package:todolist_supabase/presentation/bloc/signup_bloc/signup_bloc.dart';

import '../../../core/services/dialog_service.dart';
import '../../../core/services/toast_service.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final dialogService = DialogService();
  final toastService = ToastService();

  void signup() {
    final isValidated = _loginFormKey.currentState!.validate();
    isValidated
        ? BlocProvider.of<SignupBloc>(context).add(
            SignInButtonPressed(
              _emailController.text,
              _usernameController.text,
              _passwordController.text,
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            dialogService.closeDialog(context: context);
            toastService.errorToast(message: state.message);
          } else if (state is SignupSuccess) {
            dialogService.closeDialog(context: context);
            dialogService.closeDialog(context: context);
            toastService.successToast(message: "Signup was Success");
          } else if (state is SignupLoading) {
            dialogService.showLoadingDialog(context: context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              // padding: EdgeInsets.all(20),
              children: [
                Spacer(
                  flex: 1,
                ),
                Center(child: Text("Welcome to Svik Todo!")),
                // SizedBox(
                //   height: 60,
                // ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name";
                    }
                  },
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
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: Text("Have Already an account ?  Login"),
                ),
                ElevatedButton(
                  onPressed: () => signup(),
                  child: Text('Signup', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 52)),
                ),
                // (MediaQuery.of(context).size.height * 10) / 100 > 70
                //     ? Spacer(
                //         flex: 1,
                //       )
                //     : Container(),
                Spacer(flex: 2,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
