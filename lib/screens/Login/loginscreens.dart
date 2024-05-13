import 'package:app_tiked/components/Login/logincomponent.dart';
import 'package:app_tiked/size_config.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:flutter/material.dart';


class LoginScreens extends StatelessWidget {
  const LoginScreens({super.key});

  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: kFourthColor,
      body: LoginComponent(),
    );
  }
}