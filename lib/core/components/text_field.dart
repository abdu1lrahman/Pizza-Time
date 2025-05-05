import 'package:flutter/material.dart';
import 'package:pizza_time/core/constants/constants.dart';

// ignore: must_be_immutable, camel_case_types
class deafultTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  bool obscureText;
  bool toggle;
  EdgeInsetsGeometry padding;
  FormFieldValidator<String> validator;

  deafultTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.toggle = false,
    this.padding = const EdgeInsets.all(12.0),
  });

  @override
  State<deafultTextField> createState() => _deafultTextFieldState();
}

// ignore: camel_case_types
class _deafultTextFieldState extends State<deafultTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        textInputAction: widget.textInputAction,
        cursorColor: mainGrey,
        keyboardType: TextInputType.emailAddress,
        obscureText: widget.toggle ? false : widget.obscureText,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.label,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: (widget.obscureText)
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.toggle = !widget.toggle;
                    });
                  },
                  icon: widget.toggle
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                )
              : const SizedBox(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: mainGrey,
            ),
          ),
          // labelText: widget.label,
          // labelStyle: TextStyle(color: mainGrey),
        ),
      ),
    );
  }
}
