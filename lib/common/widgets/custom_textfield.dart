// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final bool readOnly;
  final Function()? onTap;
  final String? initialValue;
  CustomTextfield({
    this.readOnly = false,
    super.key,
    this.onTap,
    this.initialValue,
    required this.hintText,
    required this.controller,
    required this.title,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: widget.initialValue,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          validator: widget.validator,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            hintStyle: TextStyle(color: Colors.grey),
            hintText: widget.hintText,
            border: _returnBorder(),
            focusedBorder: _returnBorder(Colors.blue.shade600),
            errorBorder: _returnBorder(Colors.red),
            enabledBorder: _returnBorder(),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _returnBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color ?? Colors.grey,
      ),
    );
  }
}
