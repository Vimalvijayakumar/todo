import 'package:flutter/material.dart';

class InputTextBox extends StatelessWidget {
  final String hintText;
  final int maxlines;
  final double boxheight;
  final TextEditingController controller;
  const InputTextBox(
      {super.key,
      required this.hintText,
      required this.maxlines,
      required this.boxheight,
      re,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: boxheight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.green)),
      child: TextFormField(
          controller: controller,
          maxLines: maxlines,
          style: const TextStyle(),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            errorBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )),
    );
  }
}
