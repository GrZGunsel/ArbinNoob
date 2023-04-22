import 'package:den_ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:den_ecommerce/core/constant/den_theme.dart';

import '../core/service_locator.dart';
import '../model/cart_model.dart';
import '../provider/order_provider.dart';
import '../provider/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> productList = [];

  // _addToCart() async {
  //   List<ProductModel> lst = [];
  //   lst.add(ProductModel(
  //     productId: 1,
  //     productName: "productName",
  //     price: "22",
  //     description: "decsss",
  //     specification: "specification",
  //     image: "image",
  //     category: 2,
  //   ));

  //   setState(() {
  //     productList.addAll(lst);
  //   });
  // }

  _addToCart({required ProductModel product}) async {
    List<ProductModel> lst = [];
    lst.add(product);

    setState(() {
      productList.addAll(lst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: locator<ProductProvider>().getProduct(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Text(
                          "Products",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                locator<ProductProvider>().productList.length,
                            itemBuilder: (context, index) {
                              return Stack(children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                        color: Color(0xffF2F2F2), width: 1),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        locator<ProductProvider>()
                                            .productList[index]
                                            .image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    locator<ProductProvider>()
                                                        .productList[index]
                                                        .productName,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: DenTheme
                                                            .secondaryTextColor),
                                                  ),
                                                  Text(
                                                    locator<ProductProvider>()
                                                        .productList[index]
                                                        .price,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DenTheme
                                                            .orangeColor),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.006,
                                              ),
                                              Text(
                                                locator<ProductProvider>()
                                                    .productList[index]
                                                    .description,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    height: 1.4,
                                                    color: DenTheme
                                                        .secondaryTextColor),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.006,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.34,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              DenTheme
                                                                  .secondaryColor,
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                          "View More",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.012,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.34,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              DenTheme
                                                                  .secondaryColor,
                                                        ),
                                                        onPressed: () async {
                                                          await _addToCart(
                                                            product: locator<
                                                                    ProductProvider>()
                                                                .productList[index],
                                                          );
                                                          locator<OrderProvider>()
                                                              .addProductToCart(
                                                                  product:
                                                                      productList);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.local_mall,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.016,
                                                            ),
                                                            Text(
                                                              "Add to Cart",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ]);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
