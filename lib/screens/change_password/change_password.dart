import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar1/constants/constants.dart';
import 'package:tugas_besar1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:tugas_besar1/widgets/primary_button/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Ubah Password",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: [
          SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              labelText: "Password Baru",
              prefixIcon: Icon(
                Icons.key_outlined,
              ),
              suffixIcon: CupertinoButton(
                onPressed: () {
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
            height: 24,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              labelText: "Konfirmasi Password",
              prefixIcon: Icon(
                Icons.key_outlined,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          PrimaryButton(
            title: "Update",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("Password baru kosong");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("Konfirmasi password baru kosong");
              } else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                showMessage("Konfirmasi password salah");
              }
            },
          ),
        ],
      ),
    );
  }
}
