import 'package:flutter/material.dart';

import '../core/constant/den_theme.dart';
import '../core/service_locator.dart';
import '../provider/order_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int value = 0;

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
            Expanded(
              child: ListView.builder(
                itemCount: locator<OrderProvider>().productList.length,
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
                                  locator<OrderProvider>()
                                      .productList[index]
                                      .image,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locator<OrderProvider>()
                                        .productList[index]
                                        .productName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    locator<OrderProvider>()
                                        .productList[index]
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
                                        '\$ ${locator<OrderProvider>().productList[index].description}',
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
