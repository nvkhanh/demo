import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {Key? key,
        this.controller,
        this.errorString,
        this.textInputAction,
        this.onSubmitted,
        this.hintText,
        this.obscureText = false})
      : super(key: key);

  final TextEditingController? controller;
  final String? errorString;
  final String? hintText;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final bool obscureText;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorText: widget.errorString,
      ),
      obscureText: widget.obscureText,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
    );
  }
}
