import 'package:app_tiked/routes.dart';
import 'package:app_tiked/screens/Login/loginscreens.dart';
import 'package:app_tiked/theme.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(
    MaterialApp(
      title: "Tiked Id",
      theme: theme(),
      initialRoute: LoginScreens.routeName,
      debugShowCheckedModeBanner: false,
      routes: routes,
    ));
}