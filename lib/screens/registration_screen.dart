import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:den_ecommerce/screens/login_screen.dart';
import 'package:den_ecommerce/screens/set_password.dart';
import 'package:den_ecommerce/widgets/formWidget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/formWidget/customTextField.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  String? _fristName;
  String? _lastName;
  String? _Location;
  String? _phoneNumber;
  String? _emailAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registration",
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
              _buildFirstName(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.016,
              ),
              _buildLastName(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.016,
              ),
              _buildLocation(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.016,
              ),
              _buildPhoneNumber(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.016,
              ),
              _buildemailAddress(),
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
                      builder: (context) => SetPassword(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
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
        )),
      ),
    );
  }

  Widget _buildFirstName() {
    return CustomTextField(
      labelText: "First Name",
      isFilled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'FirstName is required';
        }
        // validator has to return something
        return null;
      },
      onSaved: (value) => _fristName = value!,
    );
  }

  Widget _buildLastName() {
    return CustomTextField(
      labelText: "Last Name",
      isFilled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Last Name is required';
        }
        // validator has to return something
        return null;
      },
      onSaved: (value) => _lastName = value!,
    );
  }

  Widget _buildLocation() {
    return CustomTextField(
      labelText: "Location",
      isFilled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Location is required';
        }
        // validator has to return something
        return null;
      },
      onSaved: (value) => _Location = value!,
    );
  }

  Widget _buildPhoneNumber() {
    return CustomTextField(
      labelText: "Phone Number",
      isFilled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Phone Number is required';
        }
        // validator has to return something
        return null;
      },
      onSaved: (value) => _phoneNumber = value!,
    );
  }

  Widget _buildemailAddress() {
    return CustomTextField(
      labelText: "Email Address ",
      isFilled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email Address is required';
        }
        // validator has to return something
        return null;
      },
      onSaved: (value) => _fristName = value!,
    );
  }
}
