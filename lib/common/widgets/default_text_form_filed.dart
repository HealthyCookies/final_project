import 'package:flutter/material.dart';

class DefaultTextFormFiled extends StatelessWidget {
  const DefaultTextFormFiled({
    super.key,
    this.controller,
    this.onChanged,
    this.labelText,
    this.inputType,
  });

  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? labelText;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: inputType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
