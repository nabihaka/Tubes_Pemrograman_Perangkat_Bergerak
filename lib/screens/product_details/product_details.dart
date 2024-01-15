import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_besar1/constants/constants.dart';
import 'package:tugas_besar1/constants/routes.dart';
import 'package:tugas_besar1/models/product_model/product_model.dart';
import 'package:tugas_besar1/provider/app_provider.dart';
import 'package:tugas_besar1/screens/buy_product/buy_product.dart';
import 'package:tugas_besar1/screens/cart_screen/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: CartScreen(), context: context);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(12.0),
              height: screenHeight * 0.87,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      widget.singleProduct.image,
                      height: 300,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.singleProduct.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.singleProduct.isFavourite =
                                !widget.singleProduct.isFavourite;
                          });
                          if (widget.singleProduct.isFavourite) {
                            appProvider
                                .addFavouriteProduct(widget.singleProduct);
                          } else {
                            appProvider
                                .removeFavouriteProduct(widget.singleProduct);
                          }
                        },
                        icon: Icon(appProvider.getFavouriteProductList
                                .contains(widget.singleProduct)
                            ? Icons.favorite
                            : Icons.favorite_border),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Rp ${widget.singleProduct.price}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    widget.singleProduct.description,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          if (qty >= 1) {
                            setState(() {
                              qty--;
                            });
                          }
                        },
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: 31,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF01C15C),
                                width: 2.0,
                              )),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.remove,
                              color: Color(0xFF01C15C),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        qty.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          setState(() {
                            qty++;
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Color(0xFF01C15C),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 225,
                        child: OutlinedButton(
                          onPressed: () {
                            ProductModel productModel =
                                widget.singleProduct.copyWith(qty: qty);
                            appProvider.addCartProduct(productModel);
                            showMessage("Ditambahkan ke keranjang");
                          },
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Color(0xFF01C15C),
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor: Color(0xFF01C15C)),
                          child: Text("TAMBAHKAN KE KERANJANG"),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 40,
                        width: 225,
                        child: ElevatedButton(
                          onPressed: () {
                            Routes.instance.push(
                                widget: Checkout(), context: context);
                          },
                          child: Text("BELI SEKARANG"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45,
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
