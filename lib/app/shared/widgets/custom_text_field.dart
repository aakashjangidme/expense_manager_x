import 'package:expense_manager_x/main.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.label,
    this.keyboardType,
    this.controller,
    this.onChanged,
  });

  final String? hintText;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        label: label != null
            ? Text(label!)
            : hintText != null
                ? Text(hintText!)
                : SizedBox.fromSize(),
        border: InputBorder.none,
        filled: false,
        alignLabelWithHint: true,
        labelStyle: Theme.of(context).textTheme.headlineSmall,
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      keyboardType: keyboardType,
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.onSaved,
  });

  final String? hintText;
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hintText,
        label: label != null
            ? Text(label!)
            : hintText != null
                ? Text(hintText!)
                : SizedBox.fromSize(),
        border: InputBorder.none,
        filled: false,
        alignLabelWithHint: true,
        labelStyle: Theme.of(context).textTheme.headlineSmall,
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      keyboardType: keyboardType,
    );
  }
}
