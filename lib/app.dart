import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_supabase/core/viewmodels/auth_viewmodel.dart';
import './presentation/app_views.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            // onBackground: Colors.black,
            // surfaceTint: Colors.amber,
            primary: Colors.purple.shade900,

            // secondary: Color.fromARGB(255, 103, 0, 248),
            // primary: Color.fromARGB(255, 25, 1, 1)
          ),
        ),
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(useMaterial3: true,colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark)),
        // darkTheme: ThemeData(
        //   useMaterial3: true,
        //   colorScheme: ColorScheme.dark(
        //     primary: Colors.purple.shade200,
        //   ),
        //   appBarTheme: AppBarTheme(
        //     backgroundColor: Colors.black26,
        //   ),
        //   floatingActionButtonTheme: FloatingActionButtonThemeData(
        //     backgroundColor: Colors.purple.shade200
        //   ),
          
        // ),
        initialRoute: '/',
        routes: {
          '/': (context) => DeceiderView(),
          '/login': (context) => LoginView(),
          '/signup': (context) => SignupView(),
          '/todos': (context) => AllTodosView(),
          '/create': (context) => CreateTodo()
        },
      ),
    );
  }
}
