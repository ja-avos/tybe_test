import 'package:flutter/material.dart';

class CustomPasswordInput extends StatefulWidget {
  final String name;
  final String hint;
  final TextEditingController? controller;

  const CustomPasswordInput({
    Key? key,
    required this.name,
    this.hint = "Escribe aquí",
    this.controller,
  }) : super(key: key);

  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
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
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: widget.hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Icon(
                isVisible
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye_rounded,
              ),
            ),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Este campo es requerido';
            }
            if (value!.length < 6) {
              return 'La contraseña debe tener al menos 6 caracteres';
            }
            if (value.length > 20) {
              return 'La contraseña debe tener máximo 20 caracteres';
            }
            return null;
          },
          obscureText: !isVisible,
          enableSuggestions: false,
          autocorrect: false,
          controller: widget.controller,
        ),
      ],
    );
  }
}
