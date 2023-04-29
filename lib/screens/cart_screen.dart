import 'package:den_ecommerce/model/cart_model.dart';
import 'package:den_ecommerce/model/product_cart_model.dart';
import 'package:den_ecommerce/model/product_model.dart';
import 'package:den_ecommerce/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constant/den_theme.dart';
import '../core/service_locator.dart';
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
  // int value = 0;
  Future? _future;
  bool _isInit = true;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isInit) {
  //     _future = _load();
  //   }
  //   _isInit = false;
  // }

  void incrementValue(int value) {
    value++;
  }

  void decrementValue(int value) {
    value--;
  }

  List<ProductModel> _list = [];

  List<ProductCartModel> _dataList = [];

  Future<void> _load() async {
    await locator<AppProvider>().getProductCart(userId: 4);
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
                                                    .image
                                                //locator<AppProvider>().productCart![index].
                                                ),
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
                                                  // SizedBox(width: 8),
                                                  // Text(
                                                  //   '\$19.99',
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     color: Colors.grey,
                                                  //     decoration:
                                                  //         TextDecoration.lineThrough,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Consumer<AppProvider>(
                                        builder: (context, value, child) =>
                                            Column(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  locator<AppProvider>()
                                                      .counter = locator<
                                                          AppProvider>()
                                                      .newProductCart![index]
                                                      .quantity;
                                                }
                                                // () => decrementValue(
                                                //     locator<AppProvider>()
                                                //         .newProductCart![index]
                                                //         .quantity),

                                                ),
                                            Text(
                                              locator<AppProvider>()
                                                  .newProductCart![index]
                                                  .quantity
                                                  .toString(), // replace with actual quantity
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () => incrementValue(
                                                  locator<AppProvider>()
                                                      .newProductCart![index]
                                                      .quantity),
                                            ),
                                          ],
                                        ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutPage(
                                      productList: locator<AppProvider>()
                                          .newProductCart!,
                                      // productId: 1,
                                      // quantity: 2,
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




// import 'package:den_ecommerce/model/cart_model.dart';
// import 'package:den_ecommerce/model/product_cart_model.dart';
// import 'package:den_ecommerce/model/product_model.dart';
// import 'package:den_ecommerce/provider/app_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../core/constant/den_theme.dart';
// import '../core/service_locator.dart';
// import '../provider/order_provider.dart';
// import '../provider/product_provider.dart';
// import 'checkout_page.dart';

// class CartPage extends StatefulWidget {
//   CartPage({
//     super.key,
//   });

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   // int value = 0;
//   Future? _future;
//   bool _isInit = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   // }

//   // @override
//   // void didChangeDependencies() {
//   //   super.didChangeDependencies();
//   //   if (_isInit) {
//   //     _future = _load();
//   //   }
//   //   _isInit = false;
//   // }

//   void incrementValue(int value) {
//     value++;
//   }

//   void decrementValue(int value) {
//     value--;
//   }

//   List<ProductModel> _list = [];

//   List<ProductCartModel> _dataList = [];

//   Future<void> _load() async {
//     await locator<AppProvider>().getProductCart(userId: 4);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.024,
//             ),
//             Text(
//               "My Carts",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.024,
//             ),
//             FutureBuilder(
//               future: locator<AppProvider>().getProductCart(
//                 userId: locator<AppProvider>().currentUser!.userId,
//               ),
//               builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                 return snapshot.connectionState == ConnectionState.waiting
//                     ? Align(
//                         alignment: Alignment.center,
//                         child: CircularProgressIndicator(),
//                       )
//                     : Column(
//                         children: [
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount:
//                                   locator<AppProvider>().newProductCart!.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 100,
//                                           height: 100,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             image: DecorationImage(
//                                               image: NetworkImage(
//                                                   locator<AppProvider>()
//                                                       .newProductCart![index]
//                                                       .product
//                                                       .image
//                                                   //locator<AppProvider>().productCart![index].
//                                                   ),
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 8.0),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   locator<AppProvider>()
//                                                       .newProductCart![index]
//                                                       .product
//                                                       .productName,
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 8),
//                                                 Text(
//                                                   locator<AppProvider>()
//                                                       .newProductCart![index]
//                                                       .product
//                                                       .description,
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 8),
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                       '\$ ${locator<AppProvider>().newProductCart![index].product.price}',
//                                                       style: TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                     // SizedBox(width: 8),
//                                                     // Text(
//                                                     //   '\$19.99',
//                                                     //   style: TextStyle(
//                                                     //     fontSize: 12,
//                                                     //     color: Colors.grey,
//                                                     //     decoration:
//                                                     //         TextDecoration.lineThrough,
//                                                     //   ),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Consumer<AppProvider>(
//                                           builder: (context, value, child) =>
//                                               Column(
//                                             children: [
//                                               IconButton(
//                                                   icon: Icon(Icons.remove),
//                                                   onPressed: () {
//                                                     locator<AppProvider>()
//                                                         .counter = locator<
//                                                             AppProvider>()
//                                                         .newProductCart![index]
//                                                         .quantity;
//                                                   }
//                                                   // () => decrementValue(
//                                                   //     locator<AppProvider>()
//                                                   //         .newProductCart![index]
//                                                   //         .quantity),

//                                                   ),
//                                               Text(
//                                                 locator<AppProvider>()
//                                                     .newProductCart![index]
//                                                     .quantity
//                                                     .toString(), // replace with actual quantity
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(Icons.add),
//                                                 onPressed: () => incrementValue(
//                                                     locator<AppProvider>()
//                                                         .newProductCart![index]
//                                                         .quantity),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           // SizedBox(
//                           //   width: MediaQuery.of(context).size.width,
//                           //   child: ElevatedButton(
//                           //       style: ElevatedButton.styleFrom(
//                           //         elevation: 0,
//                           //         backgroundColor: DenTheme.secondaryColor,
//                           //       ),
//                           //       onPressed: () {
//                           //         Navigator.push(
//                           //           context,
//                           //           MaterialPageRoute(
//                           //             builder: (context) => CheckoutPage(
//                           //               productId: 1,
//                           //               quantity: 2,
//                           //             ),
//                           //           ),
//                           //         );
//                           //       },
//                           //       child: Row(
//                           //         mainAxisAlignment: MainAxisAlignment.center,
//                           //         children: [
//                           //           Icon(
//                           //             Icons.local_mall,
//                           //             size: 18,
//                           //           ),
//                           //           SizedBox(
//                           //             width: MediaQuery.of(context).size.width *
//                           //                 0.016,
//                           //           ),
//                           //           Text(
//                           //             "Checkout",
//                           //             style: TextStyle(fontSize: 12),
//                           //           ),
//                           //         ],
//                           //       )),
//                           // ),
//                         ],
//                       );
//               },
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.width * 0.016,
//             ),
//           ],
//         ),
//       ),
//     );
//     ;
//   }
// }
