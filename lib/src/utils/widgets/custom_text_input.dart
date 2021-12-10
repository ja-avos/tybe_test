import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String name;
  final String? hint;
  final bool editable;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextInput({
    Key? key,
    required this.name,
    this.hint = "Escribe aquí",
    this.editable = true,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFD8D8D8),
                width: 1.5,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFD8D8D8),
                width: 1.5,
              ),
            ),
            labelText: hint,
          ),
          validator: validator,
          readOnly: !editable,
          controller: controller,
        ),
      ],
    );
  }
}
