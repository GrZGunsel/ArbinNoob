import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:den_ecommerce/provider/product_provider.dart';
import 'package:den_ecommerce/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../core/service_locator.dart';
import '../provider/app_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      _future = _loadData();
    }
    _isInit = false;
  }

  _loadData() async {
    await Future.wait([
      locator<ProductProvider>().getProduct(),
      locator<AppProvider>().getUserDetail(
        userId: locator<AppProvider>().currentUser!.userId,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider _provider = locator<ProductProvider>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: _future,
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
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome",
                                    style:
                                        TextStyle(color: DenTheme.primaryColor),
                                  ),
                                  Text(
                                    "${locator<AppProvider>().userDetail!.firstName} ${locator<AppProvider>().userDetail!.lastName}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _loadData();
                                },
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1597957602900-97e95de20028?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cG90cmFpdHN8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60"),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Row(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    color: DenTheme.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF135396).withOpacity(0.1),
                                        blurRadius: 48.0,
                                        offset: Offset(0, 8),
                                      ),
                                    ]),
                                width:
                                    MediaQuery.of(context).size.width * 0.752,
                                child: TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.024,
                              ),
                              Container(
                                clipBehavior: Clip.hardEdge,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: DenTheme.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF135396).withOpacity(0.1),
                                        blurRadius: 48.0,
                                        offset: Offset(0, 8),
                                      ),
                                    ]),
                                child: Icon(
                                  Icons.filter_list,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Image.network(
                                width: double.infinity,
                                fit: BoxFit.cover,
                                "https://images.unsplash.com/photo-1581432079854-2f6d5678b478?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cmF6ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          Row(
                            children: [
                              Text(
                                "Products",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      "View all",
                                      style: TextStyle(
                                          color: DenTheme.primaryColor),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: DenTheme.primaryColor,
                                  )
                                ],
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.024,
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.366),
                            items: locator<ProductProvider>().productList.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductScreen(
                                                      id: i.productId,
                                                    )));
                                      },
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: Color(0xffF2F2F2),
                                              width: 1),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              i.image,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
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
                                                        i.productName,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: DenTheme
                                                                .secondaryTextColor),
                                                      ),
                                                      Text(
                                                        i.price,
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.006,
                                                  ),
                                                  Text(
                                                    i.description,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1.4,
                                                        color: DenTheme
                                                            .secondaryTextColor),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.006,
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
                                                          // print('object');
                                                          int userId = locator<
                                                                  AppProvider>()
                                                              .currentUser!
                                                              .userId;
                                                          int productId =
                                                              i.productId;
                                                          // print("autoCart");
                                                          // print(userId);
                                                          // print(productId);
                                                          // print("adtocart");

                                                          await locator<
                                                                  AppProvider>()
                                                              .addToCart(
                                                            userId: userId,
                                                            productId:
                                                                productId,
                                                          );
                                                        },
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
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
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ).toList(),
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
