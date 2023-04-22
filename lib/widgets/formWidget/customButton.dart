import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:den_ecommerce/screens/home_screen.dart';
import 'package:den_ecommerce/screens/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: DenTheme.secondaryColor,
        elevation: 0,
        padding: EdgeInsets.all(16),
        fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
      ),
      child: Text("Login"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndexScreen(),
          ),
        );
      },
    );
  }
}
