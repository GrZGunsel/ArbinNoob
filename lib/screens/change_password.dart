import 'package:flutter/material.dart';

import '../core/constant/den_theme.dart';
import '../widgets/formWidget/customTextField.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? _password;

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Password",
                style: DenTheme.largeheadingStyle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.004,
              ),
              Text(
                "Please kindly fill up the form *",
                style: DenTheme.smallTextLabel,
              ),
              _buildPassword(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.004,
              ),
              _buildConfirmPassword(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
            ],
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
