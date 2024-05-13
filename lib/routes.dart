import 'package:app_tiked/screens/Login/loginscreens.dart';
import 'package:app_tiked/screens/Register/register.dart';
import 'package:app_tiked/screens/User/homeuserscreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  //Login dan register
  LoginScreens.routeName: (context) => LoginScreens(),
  RegisterScreen.routeName:(context) => RegisterScreen(),

  // User Screen
  HomeUserScreen.routeName:(context) => HomeUserScreen() 
};