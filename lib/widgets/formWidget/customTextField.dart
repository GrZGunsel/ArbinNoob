import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final String labelText;

  final String? initialValue;
  String? Function(String?)? onSaved;
  final Widget? prefixIcon;
  TextEditingController? controller;

  final String? Function(String?)? validator;
  bool isPassword, isToggle;
  final InputBorder enabledBorder;
  final Color fillColor;
  final int? maxLines;
  final bool? isFilled;
  final Color? borderColor;
  final double? borderRadius;
  final bool? isDense;

  CustomTextField({
    Key? key,
    this.isPassword = false,
    this.isToggle = false,
    this.isFilled = false,
    this.controller,
    this.initialValue,
    this.onSaved,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    required this.labelText,
    required this.validator,
    this.enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBC7C7C7), width: 1.0),
    ),
    this.fillColor = const Color(0xFFFBFBFB),
    this.maxLines = 1,
    this.borderColor,
    this.borderRadius = 10,
    this.isDense = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      obscureText: widget.isToggle,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // isDense: true,
        isDense: widget.isDense,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        // contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
        prefixIcon: widget.prefixIcon != null ? widget.prefixIcon : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isToggle = !widget.isToggle;
                  });
                },
                icon: Icon(
                  !widget.isToggle ? Icons.visibility : Icons.visibility_off,
                  color: DenTheme.secondaryTextColor,
                ),
              )
            : null,

        labelText: widget.labelText,
        hintStyle: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            color: DenTheme.secondaryTextColor),
        labelStyle: TextStyle(
            fontFamily: 'Poppins', color: DenTheme.secondaryTextColor),
        fillColor: DenTheme.textFieldColor,
        filled: widget.isFilled,
        hoverColor: Colors.transparent,
      ),
      onSaved: widget.onSaved,
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
    );
  }
}
