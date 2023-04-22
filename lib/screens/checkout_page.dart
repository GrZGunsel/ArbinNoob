import 'package:carousel_slider/carousel_slider.dart';
import 'package:den_ecommerce/widgets/formWidget/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../core/constant/den_theme.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _address;
  String? selectedOption;

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
        body: Padding(
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
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return _items();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: DenTheme.textLabel.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        Text(
                          '\$9.99',
                          style: DenTheme.textLabel.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.024,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax",
                          style: DenTheme.textLabel.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        Text(
                          '\$9.99',
                          style: DenTheme.textLabel.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
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
                          '\$9.99',
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
                  fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
                ),
                child: Text("Place Order"),
                onPressed: () {},
              ),
            ],
          ),
        ),
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

  Widget _items() {
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
                    "https://images.unsplash.com/photo-1586153598243-c369ce82463c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
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
                      'Product Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Product Description',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$9.99',
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
