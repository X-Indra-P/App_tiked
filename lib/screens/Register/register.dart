import 'package:app_tiked/components/Register/registercomponent.dart';
import 'package:app_tiked/size_config.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: kFourthColor,
      body: RegisterComponent(),
    );
  }
}