import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar1/constants/constants.dart';
import 'package:tugas_besar1/constants/routes.dart';
import 'package:tugas_besar1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:tugas_besar1/screens/auth_ui/sign_up/sign_up.dart';
import 'package:tugas_besar1/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:tugas_besar1/widgets/primary_button/primary_button.dart';
import 'package:tugas_besar1/widgets/top_titles/top_titles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 12.0),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopTitles(
                  subtitle: "Halo, selamat datang kembali!",
                  title: "Login",
                ),
                SizedBox(
                  height: 35.0,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: password,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.key_outlined,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      child: Icon(
                        isShowPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                PrimaryButton(
                  title: "Login",
                  onPressed: () async {
                    bool isValidated =
                        loginValidation(email.text, password.text);
                    if (isValidated) {
                      bool isLogined = await FirebaseAuthHelper.instance
                          .login(email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(
                            widget: CustomBottomBar(), context: context);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: Text(
                    "Belum punya akun?",
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Center(
                  child: CupertinoButton(
                    onPressed: () {
                      Routes.instance.push(widget: SignUp(), context: context);
                    },
                    child: Text(
                      "Buat Akun",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
