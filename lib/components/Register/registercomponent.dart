import 'package:app_tiked/components/Register/registerform.dart';
import 'package:app_tiked/size_config.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:flutter/material.dart';


class RegisterComponent extends StatefulWidget {
  @override
  _RegisterComponent createState() => _RegisterComponent();
}

class _RegisterComponent extends State<RegisterComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "REGISTRASI",
                  style: TextStyle(fontSize: 30, color: mTitleColor),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Registrasi !",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                SignUpform()
              ],
            ),
          ),
        ),
      ),
    );
  }
}