import 'package:flutter/material.dart';
import 'package:todolist_supabase/core/services/authentication_service.dart';
import 'package:todolist_supabase/core/viewmodels/auth_page_viewmodel.dart';
import 'package:todolist_supabase/core/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart' as provider;

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

  void signup(AuthViewModel authViewModel) {
    final isValidated = _loginFormKey.currentState!.validate();
    isValidated
        ? authViewModel.signup(
            context: context,
            email: _emailController.text,
            username: _usernameController.text,
            password: _passwordController.text)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel _authViewModel = provider.Provider.of<AuthViewModel>(context);
    // AuthPageViewModel _authPageViewModel =
    //     provider.Provider.of<AuthPageViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
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
              SizedBox(
                height: 60,
              ),
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
              Spacer(flex: 1,),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text("Have Already an account ?  Login"),
              ),
              ElevatedButton(
                onPressed: () => signup(_authViewModel),
                child: Text('Signup',style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width,52)
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
