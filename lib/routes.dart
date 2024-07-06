import 'package:app_tiked/screens/Login/loginscreens.dart';
import 'package:app_tiked/screens/Register/register.dart';
import 'package:app_tiked/screens/User/homeuserscreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  // Login and register
  LoginScreens.routeName: (context) => LoginScreens(),
  RegisterScreen.routeName: (context) => RegisterScreen(),

  // User Screen
  HomeUserScreen.routeName: (context) => HomeUserScreen(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tiket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreens.routeName,
      routes: routes,
    );
  }
}
