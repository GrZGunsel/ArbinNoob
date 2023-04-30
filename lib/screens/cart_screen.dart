import 'package:den_ecommerce/model/cart_model.dart';
import 'package:den_ecommerce/model/product_cart_model.dart';
import 'package:den_ecommerce/model/product_model.dart';
import 'package:den_ecommerce/provider/app_provider.dart';
import 'package:den_ecommerce/widgets/increment_decrment_bttn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constant/den_theme.dart';
import '../core/service_locator.dart';
import '../model/new_cart_model.dart';
import '../provider/order_provider.dart';
import '../provider/product_provider.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // lsit=[]
  // add this lsits
  ///////////////////////////
  ///
  ///
  ///
  ///
  List<int> _lstQty = [];

  List<ProductModel> _list = [];

  List<ProductCartModel> _dataList = [];

  int _newQty = 0;

  void updateChildState(int newState) {
    print(newState);

    _lstQty.add(newState);
    print("_lstQty.length::::${_lstQty.length}");

    // print("before:$_newQty");
    // // setState(() {
    // //   _newQty = newState;
    // // });
    // print("after:$_newQty");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: locator<AppProvider>().getProductCart(
            userId: locator<AppProvider>().currentUser!.userId,
          ),
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
                          "My Carts",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                locator<AppProvider>().newProductCart!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                locator<AppProvider>()
                                                    .newProductCart![index]
                                                    .product
                                                    .image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                locator<AppProvider>()
                                                    .newProductCart![index]
                                                    .product
                                                    .productName,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                locator<AppProvider>()
                                                    .newProductCart![index]
                                                    .product
                                                    .description,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$ ${locator<AppProvider>().newProductCart![index].product.price}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IncrementDecrement(
                                        quantity: 1,
                                        calbackFunc: updateChildState,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: DenTheme.secondaryColor,
                              ),
                              onPressed: () {
                                // List<NewCartModel>? cart =
                                //     locator<AppProvider>().newProductCart;
                                // cart!.forEach(
                                //   (element) async {
                                //     await locator<AppProvider>().updateCart(
                                //       user: locator<AppProvider>()
                                //           .currentUser!
                                //           .userId,
                                //       product: element.product.productId,
                                //       quantity: 6,
                                //       cartId: element.id,
                                //     );
                                //   },
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutPage(
                                      productList: locator<AppProvider>()
                                          .newProductCart!,
                                      // productId: 1,
                                      quantity: _newQty,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_mall,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.016,
                                  ),
                                  Text(
                                    "Checkout",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.016,
                        ),
                      ],
                    ),
                  );
          }),
    );
    ;
  }
}
