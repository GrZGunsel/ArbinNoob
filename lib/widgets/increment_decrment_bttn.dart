import 'package:den_ecommerce/core/service_locator.dart';
import 'package:den_ecommerce/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class IncrementDecrement extends StatefulWidget {
  const IncrementDecrement(
      {super.key,
      required this.quantity,
      required this.calbackFunc,
      required this.product_id,
      required this.cartId,
      required this.userId});
  final int quantity;
  final int product_id;
  final int cartId;
  final int userId;
  final Function calbackFunc;

  @override
  State<IncrementDecrement> createState() => _IncrementDecrementState();
}

class _IncrementDecrementState extends State<IncrementDecrement> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _incrementQuantity() async {
    print('btnn in');
    setState(() {
      _quantity++;
    });
    await locator<AppProvider>().updateCart(
        cartId: widget.cartId,
        user: widget.userId,
        product: widget.product_id,
        quantity: _quantity);
    widget.calbackFunc(_quantity);
    print("_quantity$_quantity");
  }

  void _decrementQuantity() async {
    print('btnn decre');
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }

      widget.calbackFunc(_quantity);
      print("_quantity::$_quantity");
    });
    await locator<AppProvider>().updateCart(
        cartId: widget.cartId,
        user: widget.userId,
        product: widget.product_id,
        quantity: _quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(Icons.remove), onPressed: _decrementQuantity),
        Text(
          _quantity.toString(),
        ),
        IconButton(icon: Icon(Icons.add), onPressed: _incrementQuantity),
      ],
    );
  }
}
