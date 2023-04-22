import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../core/service_locator.dart';
import '../provider/product_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id});
  final int id;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
        body: FutureBuilder(
          future: locator<ProductProvider>().getProductDetail(
            id: widget.id,
          ),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Image.network(
                            locator<ProductProvider>().product!.image,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                locator<ProductProvider>().product!.productName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "NPR ${locator<ProductProvider>().product!.price}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: DenTheme.orangeColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.008,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description'),
                                  Text(
                                    locator<ProductProvider>()
                                        .product!
                                        .description,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: DenTheme.secondaryTextColor,
                                        height: 1.9),
                                  ),
                                  Text('Specification'),
                                  Text(
                                    locator<ProductProvider>()
                                        .product!
                                        .specification,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: DenTheme.secondaryTextColor,
                                        height: 1.9),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DenTheme.secondaryColor,
                              elevation: 0,
                              padding: EdgeInsets.all(16),
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 50.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_mall,
                                  size: 18,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.016,
                                ),
                                Text("Add to Cart"),
                              ],
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
