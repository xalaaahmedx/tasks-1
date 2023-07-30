import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final void Function()? onTap;
  final Color? buttonColor;
  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.buttonColor,
  });

  @override
  State<CustomButton> createState() => _CustomButton();
}

class _CustomButton extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: widget.buttonColor ?? Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
    );
  }
}
