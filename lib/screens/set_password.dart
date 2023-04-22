import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:den_ecommerce/screens/login_screen.dart';
import 'package:den_ecommerce/screens/registration_screen.dart';
import 'package:den_ecommerce/widgets/formWidget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/formWidget/customTextField.dart';

class SetPassword extends StatelessWidget {
  SetPassword({super.key});

  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Set a Password",
                  style: DenTheme.largeheadingStyle,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.004,
                ),
                Text(
                  "Please kindly fill up the form *",
                  style: DenTheme.smallTextLabel,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.024,
                ),
                _buildPassword(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.016,
                ),
                _buildConfirmPassword(),
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
                  child: Text("Proceed"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: DenTheme.textLabel,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: DenTheme.textLabel
                            .copyWith(color: DenTheme.primaryColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return CustomTextField(
      labelText: "Password",
      isPassword: true,
      isFilled: true,
      validator: (value) {
        int len = value!.length;
        if (value.isEmpty) {
          return 'Password is empty';
        }
        if (len == 0 || len < 6) {
          return 'Password must be at least 6 character';
        }
      },
      onSaved: (value) => _password = value!,
    );
  }

  Widget _buildConfirmPassword() {
    return CustomTextField(
      labelText: "Confirm password",
      isPassword: true,
      isFilled: true,
      validator: (value) {
        int len = value!.length;
        if (value.isEmpty) {
          return 'Password is empty';
        }
        if (len == 0 || len < 6) {
          return 'Password must be at least 6 character';
        }
      },
      onSaved: (value) => _password = value!,
    );
  }
}
