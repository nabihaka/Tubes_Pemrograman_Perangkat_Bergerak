import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_besar1/constants/routes.dart';
import 'package:tugas_besar1/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:tugas_besar1/models/category_model/category_model.dart';
import 'package:tugas_besar1/models/product_model/product_model.dart';
import 'package:tugas_besar1/provider/app_provider.dart';
import 'package:tugas_besar1/screens/category_view/category_view.dart';
import 'package:tugas_besar1/screens/product_details/product_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Sandhika Shop",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Cari disini",
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Text(
                          "Kategori",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        categoriesList.isEmpty
                            ? Center(
                                child: Text("Kategori kosong"),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Row(
                                  children: categoriesList
                                      .map(
                                        (e) => Container(
                                          child: CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              Routes.instance.push(
                                                  widget: CaategoryView(
                                                      categoryModel: e),
                                                  context: context);
                                            },
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(e.image),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Text(
                          "Best Products",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        productModelList.isEmpty
                            ? Center(
                                child: Text("Best product kosong"),
                              )
                            : GridView.builder(
                                padding: EdgeInsets.only(bottom: 50.0),
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
