import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class IncrementDecrement extends StatefulWidget {
  const IncrementDecrement(
      {super.key, required this.quantity, required this.calbackFunc});
  final int quantity;
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

  void _incrementQuantity() {
    print('btnn in');
    setState(() {
      _quantity++;
    });
    widget.calbackFunc(_quantity);
    print("_quantity$_quantity");
  }

  void _decrementQuantity() {
    print('btnn decre');
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
      widget.calbackFunc(_quantity);
      print("_quantity::$_quantity");
    });
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
