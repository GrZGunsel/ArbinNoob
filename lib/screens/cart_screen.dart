import 'package:den_ecommerce/model/cart_model.dart';
import 'package:den_ecommerce/model/product_cart_model.dart';
import 'package:den_ecommerce/model/product_model.dart';
import 'package:den_ecommerce/provider/app_provider.dart';
import 'package:flutter/material.dart';

import '../core/constant/den_theme.dart';
import '../core/service_locator.dart';
import '../provider/order_provider.dart';
import '../provider/product_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int value = 0;
  Future? _future;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _future = _load();
    }
    _isInit = false;
  }

  void incrementValue() {
    setState(() {
      value++;
    });
  }

  void decrementValue() {
    setState(() {
      value--;
    });
  }

  List<ProductModel> _list = [];

  List<ProductCartModel> _dataList = [];

  Future<void> _load() async {
    await Future.wait([
      locator<AppProvider>()
          .getProductCart(userId: locator<AppProvider>().currentUser!.userId)
          .then(
            (value) => locator<AppProvider>().getDummyProdcutCart(
              id: locator<AppProvider>().currentUser!.userId,
              productCartLst: locator<AppProvider>().productCart!,
            ),
          ),
    ]);
  }

  _loadData() async {
    // await Future.wait([
    //   locator<AppProvider>()
    //       .getProductCart(userId: locator<AppProvider>().currentUser!.userId),
    //   locator<AppProvider>().getDummyProdcutCart(
    //     id: locator<AppProvider>().currentUser!.userId,
    //     productCartLst: locator<AppProvider>().productCart!,
    //   ),
    // ]);
    await locator<AppProvider>()
        .getProductCart(userId: locator<AppProvider>().currentUser!.userId);

    await locator<AppProvider>().getDummyProdcutCart(
      id: locator<AppProvider>().currentUser!.userId,
      productCartLst: locator<AppProvider>().productCart!,
    );
    // print('utshaaa');
    // print(productCartLst.length);
    // print('utshaaa');
    // List<ProductCartModel> pCList = [];
    // await locator<AppProvider>().getProductCart(userId: userId).then(
    //   (value) {
    //     List<CartModel> productCartLst = locator<AppProvider>().productCart!;

    //     productCartLst.forEach(
    //       (element) {
    //         locator<ProductProvider>().getProductDetail(id: element.product);
    //       },
    //     );

    //   },

    // productCartLst.forEach(
    //   (element) async {
    //     await locator<ProductProvider>()
    //         .getProductDetail(id: element.product)
    //         .then((value) => locator<AppProvider>().getDummyProdcutCart(
    //               id: userId,
    //               element: element,
    //               productModel: locator<ProductProvider>().product!,
    //             ));

    // ProductModel product = locator<ProductProvider>().product!;
    // ProductCartModel dummyProdcutCart = ProductCartModel(
    //   user: userId,
    //   product: product,
    //   quantity: element.product,
    // );
    // print('whyyyy');
    // print(dummyProdcutCart.product.productName);
    // print('whyyyy');
    // pCList.add(dummyProdcutCart);

    // //pCList.add(dummyProdcutCart);
    // // setState(() {
    // // });
    // print('whattttt');
    // print(pCList.length);
    // print('whattttt');
    // },
    //);

    // print('ist donee');
    // print(_dataList.length);
    // print('ist donee');
    // setState(() {
    //   _list =
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.024,
            ),
            Text(
              "My Carts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.024,
            ),
            FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    //: Text('Hurray');
                    : Expanded(
                        child: ListView.builder(
                          itemCount: locator<AppProvider>().dummyList!.length,
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
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              locator<AppProvider>()
                                                  .dummyList![index]
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
                                                  .dummyList![index]
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
                                                  .dummyList![index]
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
                                                  '\$ ${locator<AppProvider>().dummyList![index].product.price}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
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
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: decrementValue,
                                          // TODO: decrease item quantity
                                        ),
                                        Text(
                                          '$value', // replace with actual quantity
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: incrementValue,
                                          // TODO: increase item quantity
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: DenTheme.secondaryColor,
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_mall,
                        size: 18,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.016,
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
      ),
    );
    ;
  }
}
