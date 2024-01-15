import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_besar1/provider/app_provider.dart';
import 'package:tugas_besar1/screens/cart_screen/widgets/single_cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Keranjang",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? Center(
              child: Text("Keranjang kosong"),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12.0),
              itemCount: appProvider.getCartProductList.length,
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              }),
    );
  }
}
