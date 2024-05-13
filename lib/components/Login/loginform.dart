import 'dart:html';

import 'package:app_tiked/components/custom_surfix_icon.dart';
import 'package:app_tiked/components/default_button_custome_color.dart';
import 'package:app_tiked/screens/Register/register.dart';
import 'package:app_tiked/screens/User/homeuserscreen.dart';
import 'package:app_tiked/size_config.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class SinginForm extends StatefulWidget {
  const SinginForm({super.key});

  @override

  State<SinginForm> createState() => _SinginFormState();
}

class _SinginFormState extends State<SinginForm> {

  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remeber = false;

  TextEditingController txtUserName = TextEditingController(),
      txtPassword = TextEditingController();


  FocusNode focusNode = new FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    final token = myStorage.read('token');
    if (token != null) {
      // Jika pengguna sudah login, arahkan ke halaman login page
         Navigator.pushNamed(context, HomeUserScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: [
            buildUserName(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPassword(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Row(
              children: [
                Checkbox(
                  value: remeber, 
                  onChanged: (value) { 
                    setState(() {
                      remeber = value;  
                    });
                  }),
                  Text("Ingat Saya"),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text("Saya Lupa Sama Password Saya", 
                    style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
              ],
            ),
            DefaultButtonCustomeColor(
              color: kPrimaryColor,
              text: "SingIn",
              press: () {

                goLogin(context, dio, myStorage, apiUrl, emailController, passwordController);
              },

            ),
            SizedBox(height: 20,
            ),
            GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      "Belum Punya Akun? Daftar Sekarang!", 
                      style: TextStyle(
                        decoration: TextDecoration.underline),
                    ),
                  ),
            buildOtherLogin(),
            SizedBox(height: getProportionateScreenHeight(30)),      
          ],
         ),
      );
  }

  TextFormField buildUserName(){
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukan Email Kalian',
        labelStyle: TextStyle(color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        )),
    );
  }


  TextFormField buildPassword(){
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukan Password Kalian',
        labelStyle: TextStyle(color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        )),
    );
  }
   Widget buildOtherLogin(){
    return Center(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          Text("atau Login dengan"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/1.png")),
              Tab(icon: Image.asset("assets/images/3.png")),
              Tab(icon: Image.asset("assets/images/4.png")),
            ],
          )
        ],
      ),
    );
  }

}

void goLogin(BuildContext context, dio, myStorage, apiUrl, emailController,
    passwordController) async {
  try {
    final response = await dio.post(
      '$apiUrl/login',
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.data);

    myStorage.write('token', response.data['data']['token']);

    Navigator.pushNamed(context, HomeUserScreen.routeName);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}