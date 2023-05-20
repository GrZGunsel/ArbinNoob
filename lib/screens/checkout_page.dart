import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:den_ecommerce/model/new_cart_model.dart';
import 'package:den_ecommerce/screens/home_screen.dart';
import 'package:den_ecommerce/screens/index_screen.dart';
import 'package:den_ecommerce/widgets/formWidget/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';

import '../core/constant/den_theme.dart';
import '../core/service_locator.dart';
import '../model/order_model.dart';
import '../provider/app_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key,
      // required this.productId,
      // required this.quantity,
      required this.productList});

  // final int productId;
  // final int quantity;
  final List<NewCartModel> productList;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _address;
  String? selectedOption = "Cash on Delivery";
  double _total = 0.0;

  List _list = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // await updateCart();

    grandTotal();
  }

  // updateCart() async {
  //   List<NewCartModel>? cart = locator<AppProvider>().newProductCart;
  //   cart!.forEach(
  //     (element) async {
  //       await locator<AppProvider>().updateCart(
  //         user: locator<AppProvider>().currentUser!.userId,
  //         product: element.product.productId,
  //         quantity: 6,
  //         cartId: element.id,
  //       );
  //     },
  //   );
  // }

  getProductList() {
    print("widget.productList:::${widget.productList}");
    List _productList = [];
    widget.productList.forEach((element) {
      print("shitty ${element.product}");
      print("postqunatity ${element.quantity}");

      _productList.add(
          {"product": element.product.productId, "quantity": element.quantity});
    });
    setState(() {
      _list = _productList;
    });
  }

  void _checkOut() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("_adress::$_address");
      print("selectedOption::$selectedOption");
      getProductList();
      await locator<AppProvider>().order(
          deliveryAddress: _address!,
          isPaid: false,
          deliveryOption: selectedOption!,
          products: _list,
          user: locator<AppProvider>().currentUser!.userId);
      print('sucess mssg');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Order Succesfully!"),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndexScreen(),
        ),
      );
    }
    // final config = PaymentConfig(
    //   amount: 10000, // Amount should be in paisa
    //   productIdentity: 'dell-g5-g5510-2021',
    //   productName: 'Dell G5 G5510 2021',
    //   productUrl: 'https://www.khalti.com/#/bazaar',
    //   additionalData: {
    //     // Not mandatory; can be used for reporting purpose
    //     'vendor': 'Khalti Bazaar',
    //   },
    //   mobile:
    //       '9800000001', // Not mandatory; can be used to fill mobile number field
    //   mobileReadOnly:
    //       true, // Not mandatory; makes the mobile field not editable
    // );
    // KhaltiScope.of(context).pay(
    //   config: config,
    //   preferences: [
    //     PaymentPreference.connectIPS,
    //     PaymentPreference.eBanking,
    //     PaymentPreference.sct,
    //   ],
    //   onSuccess: (s) async {

    //   },
    //   onFailure: (f) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text("Order Failed!"),
    //       ),
    //     );
    //   },
    //   onCancel: () {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text("Order Failed!"),
    //       ),
    //     );
    //   },
    // );
  }

  grandTotal() {
    double totalCost = widget.productList.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (double.parse(element.product.price) * element.quantity));
    setState(() {
      _total = totalCost;
    });
    // double? amt;
    // widget.productList.forEach((element) {
    //   double price = double.parse(element.product.price);
    //   print("price:::$price");
    //   int qty = element.quantity;
    //   print("qty::$qty");
    //   amt = qty * price;
    //   print("amt ::::$amt");
    // });
    print("amt111 ::::$totalCost");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: DenTheme.secondaryColor),
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [],
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Proceed to Checkout",
                    style: DenTheme.largeheadingStyle,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.023,
                  ),
                  Text(
                    "Products",
                    style: DenTheme.textLabel
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.7,
                        disableCenter: true,
                        height: MediaQuery.of(context).size.height * 0.12),
                    items: widget.productList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return _items(i);
                          // return Text('uss');
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.024,
                  ),
                  Text(
                    "Delivery Address",
                    style: DenTheme.textLabel
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  _deliveryAddress(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.024,
                  ),
                  Text(
                    "Payment Options",
                    style: DenTheme.textLabel
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: Column(
                      children: [
                        RadioListTile(
                          title: Text('Cash on Delivery'),
                          value: 'Cash on Delivery',
                          groupValue: selectedOption,
                          selected: true,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('Online Payment'),
                          value: 'Online Payment',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color(0xffF2F2F2),
                    ),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Total",
                        //       style: DenTheme.textLabel.copyWith(
                        //           fontWeight: FontWeight.w400, fontSize: 16),
                        //     ),
                        //     Text(
                        //       '\$9.99',
                        //       style: DenTheme.textLabel.copyWith(
                        //           fontWeight: FontWeight.w600, fontSize: 16),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.024,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Tax",
                        //       style: DenTheme.textLabel.copyWith(
                        //           fontWeight: FontWeight.w400, fontSize: 16),
                        //     ),
                        //     Text(
                        //       '\$9.99',
                        //       style: DenTheme.textLabel.copyWith(
                        //           fontWeight: FontWeight.w600, fontSize: 16),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        Divider(
                          height: 2,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand total",
                              style: DenTheme.textLabel.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Text(
                              _total.toString(),
                              style: DenTheme.textLabel.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.032,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DenTheme.secondaryColor,
                        elevation: 0,
                        padding: EdgeInsets.all(16),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width, 50.0),
                      ),
                      child: Text("Place Order"),
                      onPressed: _checkOut),
                ],
              ),
            ),
          )
          // FutureBuilder(
          //   future:
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     return snapshot.connectionState == ConnectionState.waiting
          //         ? Align(
          //             alignment: Alignment.center,
          //             child: CircularProgressIndicator(),
          //           )
          //         :
          //   },
          // ),
          ),
    );
  }

  Widget _deliveryAddress() {
    return CustomTextField(
      labelText: "Delivery Address ",
      isFilled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Delivery Address is required';
        }
        // validator has to return something
        return null;
      },
      onSaved: (value) => _address = value!,
    );
  }

  Widget _items(NewCartModel i) {
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
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    i.product.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      i.product.productName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      i.product.description,
                      maxLines: 1,
                      // overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      i.product.price.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////
///import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:den_ecommerce/model/new_cart_model.dart';
// import 'package:den_ecommerce/widgets/formWidget/customTextField.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../core/constant/den_theme.dart';
// import '../core/service_locator.dart';
// import '../model/order_model.dart';
// import '../provider/app_provider.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage(
//       {super.key,
//       // required this.productId, required this.quantity,
//       required this.productList});

//   // final int productId;
//   // final int quantity;
//   final List<NewCartModel> productList;

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   String? _address;
//   String? selectedOption;

//   List _list = [];

//   // void getProductList() {
//   //   _list!.add(Product(product: widget.productId, quantity: widget.quantity));
//   //   print("_list:::${_list!.length}");
//   // }

//   @override
//   void initState() {
//     super.initState();
//     //getProductList();
//   }

//   getProductList() {
//     print("widget.productList:::${widget.productList}");
//     List _productList = [];
//     widget.productList.forEach((element) {
//       final product = OrderProduct(
//           product: element.product.productId, quantity: element.quantity);
//       // final json = orderProductModelToMap(product);
//       // print(":::json:");
//       // print(json);
//       // print(":::json:");
//       _list.add(product);
//     });
//     // setState(() {
//     //   // _list = jsonEncode(_productList.)
//     // });
//     // print("::ddd:::");
//     // print(_list.length);
//     // print(_list[0].product);
//     // print(":::dddd::");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: DenTheme.secondaryColor),
//           leading: IconButton(
//             icon: Icon(Icons.chevron_left),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           actions: [],
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         body: FutureBuilder(
//           future: locator<AppProvider>().order(
//               deliveryAddress: "banepa",
//               isPaid: false,
//               deliveryOption: "express",
//               products: _list,
//               // [
//               //   {"product": 1, "quantity": 2},
//               //   {"product": 2, "quantity": 1}
//               // ],
//               user: locator<AppProvider>().currentUser!.userId),
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             return snapshot.connectionState == ConnectionState.waiting
//                 ? Align(
//                     alignment: Alignment.center,
//                     child: CircularProgressIndicator(),
//                   )
//                 : Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Proceed to Checkout",
//                           style: DenTheme.largeheadingStyle,
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.023,
//                         ),
//                         GestureDetector(
//                           onTap: () async {
//                             await getProductList();
//                           },
//                           child: Text(
//                             "Products",
//                             style: DenTheme.textLabel.copyWith(
//                                 fontWeight: FontWeight.w600, fontSize: 18),
//                           ),
//                         ),
//                         CarouselSlider(
//                           options: CarouselOptions(
//                               aspectRatio: 16 / 9,
//                               enableInfiniteScroll: true,
//                               viewportFraction: 0.7,
//                               disableCenter: true,
//                               height:
//                                   MediaQuery.of(context).size.height * 0.12),
//                           items: [1, 2, 3, 4, 5].map((i) {
//                             return Builder(
//                               builder: (BuildContext context) {
//                                 return _items();
//                               },
//                             );
//                           }).toList(),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.024,
//                         ),
//                         Text(
//                           "Delivery Address",
//                           style: DenTheme.textLabel.copyWith(
//                               fontWeight: FontWeight.w600, fontSize: 18),
//                         ),
//                         _deliveryAddress(),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.024,
//                         ),
//                         Text(
//                           "Payment Options",
//                           style: DenTheme.textLabel.copyWith(
//                               fontWeight: FontWeight.w600, fontSize: 18),
//                         ),
//                         SizedBox(
//                           height: 140,
//                           width: double.infinity,
//                           child: Column(
//                             children: [
//                               RadioListTile(
//                                 title: Text('Cash on Delivery'),
//                                 value: 'Cash on Delivery',
//                                 groupValue: selectedOption,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedOption = value;
//                                   });
//                                 },
//                               ),
//                               RadioListTile(
//                                 title: Text('Online Payment'),
//                                 value: 'Online Payment',
//                                 groupValue: selectedOption,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedOption = value;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           clipBehavior: Clip.hardEdge,
//                           padding: EdgeInsets.all(20.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12.0),
//                             color: Color(0xffF2F2F2),
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Total",
//                                     style: DenTheme.textLabel.copyWith(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16),
//                                   ),
//                                   Text(
//                                     '\$9.99',
//                                     style: DenTheme.textLabel.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.024,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Tax",
//                                     style: DenTheme.textLabel.copyWith(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16),
//                                   ),
//                                   Text(
//                                     '\$9.99',
//                                     style: DenTheme.textLabel.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.010,
//                               ),
//                               Divider(
//                                 height: 2,
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.010,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Grand total",
//                                     style: DenTheme.textLabel.copyWith(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16),
//                                   ),
//                                   Text(
//                                     '\$9.99',
//                                     style: DenTheme.textLabel.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.032,
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: DenTheme.secondaryColor,
//                             elevation: 0,
//                             padding: EdgeInsets.all(16),
//                             fixedSize:
//                                 Size(MediaQuery.of(context).size.width, 50.0),
//                           ),
//                           child: Text("Place Order"),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _deliveryAddress() {
//     return CustomTextField(
//       labelText: "Delivery Address ",
//       isFilled: true,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Delivery Address is required';
//         }
//         // validator has to return something
//         return null;
//       },
//       onSaved: (value) => _address = value!,
//     );
//   }

//   Widget _items() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     "https://images.unsplash.com/photo-1586153598243-c369ce82463c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Product Name',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Product Description',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       '\$9.99',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///
