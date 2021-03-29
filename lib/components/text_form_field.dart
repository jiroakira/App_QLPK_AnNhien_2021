import 'package:flutter/material.dart';
import 'package:medapp/model/login.dart';

import '../utils/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final Widget suffixIcon;
  final bool suffixIconTap;
  final String error;
  final TextInputType keyboardType;
  final Function validator;
  final Function onSaved;
  final String labelText;
  final Function onTap;
  final bool readOnly;

  const CustomTextFormField({
    Key key,
    this.controller,
    @required this.hintText,
    this.keyboardType,
    this.obscureText,
    this.enabled,
    this.suffixIcon,
    this.suffixIconTap,
    this.error,
    this.validator,
    this.onSaved,
    this.labelText,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText;

  LoginRequestModel requestModel;
  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText ?? false,
      controller: widget.controller,
      enabled: widget.enabled ?? true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: Colors.grey[500],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[200],
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[200],
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 20,
          color: Color(0xffbcbcbc),
          fontFamily: 'OpenSans',
        ),
        errorText: widget.error ?? null,
        suffixIcon: (widget.obscureText != null && widget.obscureText)
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    size: 15,
                  ),
                ),
              )
            : widget.suffixIcon,
      ),
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[700],
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.normal,
      ),
      cursorColor: kColorBlue,
      cursorWidth: 1,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
