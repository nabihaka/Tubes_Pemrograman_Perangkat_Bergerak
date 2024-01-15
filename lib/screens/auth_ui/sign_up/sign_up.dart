import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar1/constants/constants.dart';
import 'package:tugas_besar1/constants/routes.dart';
import 'package:tugas_besar1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:tugas_besar1/screens/auth_ui/login/login.dart';
import 'package:tugas_besar1/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:tugas_besar1/widgets/primary_button/primary_button.dart';
import 'package:tugas_besar1/widgets/top_titles/top_titles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopTitles(
                    subtitle: "Selamat datang di Toko Sandhika",
                    title: "Buat Akun",
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
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
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "No.telp",
                      prefixIcon: Icon(
                        Icons.phone,
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
                    title: "Buat Akun",
                    onPressed: () async{
                      bool isValidated =
                        signUpValidation(name.text, email.text, phone.text, password.text);
                    if (isValidated) {
                      bool isLogined = await FirebaseAuthHelper.instance
                          .signUp(name.text, email.text, password.text, context);
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
                      "Sudah punya akun?",
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Center(
                    child: CupertinoButton(
                      onPressed: () {
                        Routes.instance.push(widget: Login(), context: context);
                      },
                      child: Text(
                        "Login",
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
      ),
    );
  }
}
