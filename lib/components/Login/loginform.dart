import 'package:app_tiked/components/custom_surfix_icon.dart';
import 'package:app_tiked/components/default_button_custome_color.dart';
import 'package:app_tiked/screens/Register/register.dart';
import 'package:app_tiked/screens/User/homeuserscreen.dart';
import 'package:app_tiked/size_config.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;

  TextEditingController txtUserName = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = FocusNode();

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
      Navigator.pushNamed(context, HomeUserScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Ingat Saya"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Saya Lupa Sama Password Saya",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Sign In",
            press: () {
              if (_formKey.currentState!.validate()) {
                goLogin(context, dio, myStorage, apiUrl, emailController, passwordController);
              }
            },
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: Text(
              "Belum Punya Akun? Daftar Sekarang!",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          buildOtherLogin(),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukan Email Kalian',
        labelStyle: TextStyle(color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan email Anda';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Masukkan email yang valid';
        }
        return null;
      },
    );
  }

  TextFormField buildPassword() {
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
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan password Anda';
        }
        if (value.length < 6) {
          return 'Password harus terdiri dari minimal 6 karakter';
        }
        return null;
      },
    );
  }

  Widget buildOtherLogin() {
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
          ),
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