import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_besar1/provider/app_provider.dart';
import 'package:tugas_besar1/screens/favourite_screen/widgets/single_favourite_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wishlist",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(
              child: Text("Wishlist kosong"),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12.0),
              itemCount: appProvider.getFavouriteProductList.length,
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              }),
    );
  }
}
