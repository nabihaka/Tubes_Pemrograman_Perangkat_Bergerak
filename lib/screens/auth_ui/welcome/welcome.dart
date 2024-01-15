import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar1/constants/asset_images.dart';
import 'package:tugas_besar1/constants/routes.dart';
import 'package:tugas_besar1/screens/auth_ui/login/login.dart';
import 'package:tugas_besar1/screens/auth_ui/sign_up/sign_up.dart';
import 'package:tugas_besar1/widgets/primary_button/primary_button.dart';
import 'package:tugas_besar1/widgets/top_titles/top_titles.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopTitles(subtitle: "Mari belanja peralatan elektronik di Toko Sandhika!", title: "Selamat Datang"),
                Center(
                  child: Image.asset(AssetsImages.instance.welcomeImage),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.facebook,
                        size: 38,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                        AssetsImages.instance.googleLogo,
                        scale: 30.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                PrimaryButton(
                  title: "Login",
                  onPressed: () {
                    Routes.instance.push(widget: Login(), context: context);
                  },
                ),
                SizedBox(
                  height: 18.0,
                ),
                PrimaryButton(
                  title: "Sign Up",
                  onPressed: () {
                    Routes.instance.push(widget: SignUp(), context: context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
