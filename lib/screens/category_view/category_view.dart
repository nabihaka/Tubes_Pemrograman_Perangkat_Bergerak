import 'package:flutter/material.dart';
import 'package:tugas_besar1/constants/routes.dart';
import 'package:tugas_besar1/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:tugas_besar1/models/category_model/category_model.dart';
import 'package:tugas_besar1/models/product_model/product_model.dart';
import 'package:tugas_besar1/screens/product_details/product_details.dart';

class CaategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CaategoryView({super.key, required this.categoryModel});

  @override
  State<CaategoryView> createState() => _CaategoryViewState();
}

class _CaategoryViewState extends State<CaategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryModel.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Color(0xFF01C15C),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productModelList.isEmpty
                            ? Center(
                                child: Text("Best product kosong"),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: productModelList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        crossAxisCount: 2),
                                itemBuilder: (ctx, index) {
                                  ProductModel singleProduct =
                                      productModelList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFF01C15C).withOpacity(0.3),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Image.network(
                                          singleProduct.image,
                                          height: 130,
                                          width: 130,
                                        ),
                                        SizedBox(
                                          height: 7.0,
                                        ),
                                        Text(
                                          singleProduct.name,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Harga: Rp ${singleProduct.price}",
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 35,
                                          width: 120,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color: Color(0xFF01C15C),
                                                ),
                                                backgroundColor:
                                                    Color(0xFF01C15C),
                                                foregroundColor: Colors.white),
                                            onPressed: () {
                                              Routes.instance.push(
                                                  widget: ProductDetails(
                                                      singleProduct:
                                                          singleProduct),
                                                  context: context);
                                            },
                                            child: Text(
                                              "Beli",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
