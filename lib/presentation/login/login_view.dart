import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_supabase/core/viewmodels/auth_page_viewmodel.dart';
import 'package:todolist_supabase/core/viewmodels/auth_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  void login(AuthViewModel authViewModel) {
    final isValidated = _loginFormKey.currentState!.validate();
    isValidated
        ? authViewModel.login(
            context: context,
            email: _emailController.text,
            password: _passwordController.text,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel _authViewModel = Provider.of<AuthViewModel>(context);
    // AuthPageViewModel _authPageViewModel =
    //     Provider.of<AuthPageViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
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
                Spacer(flex: 1,),
                TextButton(
                  onPressed: ()=>Navigator.pushNamed(context, '/signup'),
                  // onPressed: () => _authPageViewModel.NavigateToIndex(index: 1),
                  child: Text("Don't have a account ?  Signup"),
                ),
                
                ElevatedButton(
                  onPressed: () => login(_authViewModel),
                  child: Text('Login',style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 52)
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ));
  }
}
