import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:den_ecommerce/provider/app_provider.dart';
import 'package:den_ecommerce/screens/registration_screen.dart';
import 'package:den_ecommerce/widgets/formWidget/customButton.dart';
import 'package:den_ecommerce/widgets/formWidget/customTextField.dart';
import 'package:flutter/material.dart';

import '../core/service_locator.dart';
import 'index_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _userName;

  String? _password;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // print('cdddcd');
      // print(",,,,,,,,,,,,");
      // print(_userName);
      // print(_password);
      // print(",,,,,,,,,,,,");
      await locator<AppProvider>().login(
        username: _userName!,
        password: _password!,
      );
      // setState(() {
      //   _isLoading = true;
      // });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndexScreen(),
        ),
      );
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.024,
                  ),
                  Image.asset('assets/images/DEN.png'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.024,
                  ),
                  Text(
                    "Login Panel",
                    style: DenTheme.largeheadingStyle,
                  ),
                  Text(
                    "Please enter your email and password to proceed.",
                    style: DenTheme.smallTextLabel,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.024,
                  ),
                  _buildUserName(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.016,
                  ),
                  _buildPassword(),
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
                    child: Text("Login"),
                    onPressed: _login,
                    //()
                    //{
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => IndexScreen(),
                    //   ),
                    // );
                    // },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ?",
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
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: Text(
                            "Register",
                            style: DenTheme.textLabel
                                .copyWith(color: DenTheme.primaryColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return CustomTextField(
      labelText: "Username",
      isFilled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Username is required';
        }
        // validator has to return something
        return null;
      },
      onSaved: (value) => _userName = value!,
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
        // if (len == 0 || len < 6) {
        //   return 'Password must be at least 6 character';
        // }
      },
      onSaved: (value) => _password = value!,
    );
  }
}
