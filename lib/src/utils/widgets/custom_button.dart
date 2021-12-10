import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final Function() onPressed;

  final bool onlyText;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.onlyText = false,
  }) : super(key: key);

  Widget _buildButton(BuildContext context) {
    return TextButton(
      child: Text(text),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        )),
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildOnlyText(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return onlyText ? _buildOnlyText(context) : _buildButton(context);
  }
}
