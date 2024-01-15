import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_besar1/constants/routes.dart';
import 'package:tugas_besar1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:tugas_besar1/provider/app_provider.dart';
import 'package:tugas_besar1/screens/about_us/about_us.dart';
import 'package:tugas_besar1/screens/change_password/change_password.dart';
import 'package:tugas_besar1/screens/edit_profile/edit_profile.dart';
import 'package:tugas_besar1/screens/favourite_screen/favourite_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Akun",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  appProvider.getUserInformation.image == null
                      ? Icon(
                          Icons.person_outlined,
                          size: 110,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              appProvider.getUserInformation.image!),
                          radius: 70,
                        ),
                  Text(
                    appProvider.getUserInformation.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    appProvider.getUserInformation.email,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 40,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        Routes.instance
                            .push(widget: EditProfile(), context: context);
                      },
                      child: Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text("Pesanan Anda"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: FavouriteScreen(), context: context);
                    },
                    leading: Icon(Icons.favorite_outline),
                    title: Text("Wishlist"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: AboutUs(), context: context);
                    },
                    leading: Icon(Icons.info_outline),
                    title: Text("About us"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.support_outlined),
                    title: Text("Support"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: ChangePassword(), context: context);
                    },
                    leading: Icon(Icons.change_circle_outlined),
                    title: Text("Ubah password"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Log out"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Version 1.0.0"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
