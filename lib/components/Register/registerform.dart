import 'package:app_tiked/components/custom_surfix_icon.dart';
import 'package:app_tiked/components/default_button_custome_color.dart';
import 'package:app_tiked/screens/Login/loginscreens.dart';
import 'package:app_tiked/size_config.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';



class SignUpform extends StatefulWidget {
  @override
  _SignUpform createState() => _SignUpform();
}

class _SignUpform extends State<SignUpform> {
  final _formKey = GlobalKey<FormState>();
  String? namalengkap;
  String? username;
  String? email;
  String? password;
  bool? remember = false;

  TextEditingController txtNamaLengkap = TextEditingController(),
      txtUserName = TextEditingController(),
      txtEmail = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';



  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNamaLengkap(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmail(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Register",
            press: () {
              goRegister(context, dio, myStorage, apiUrl, nameController, emailController, passwordController);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreens.routeName);
            },
            child: Text(
              "Sudah Punya Akun? Masuk Disini",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildNamaLengkap() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama Lengkap',
          hintText: 'Masukan Nama Lengkap',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: emailController,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Masukan Email',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/account.svg",
          )),
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Masukan Password',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Mail.svg",
          )),
    );
  }
}

// fungsi register
void goRegister(BuildContext context, dio, myStorage, apiUrl, nameController,
    emailController, passwordController) async {
  try {
    final response = await dio.post('$apiUrl/register', data: {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });
    print(response.data);

    // pindah ke login
    
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}