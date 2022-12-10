

import 'package:flutter/material.dart';

import '../../../helper/helpers.dart';

class FormFields extends StatelessWidget {
  const FormFields(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.keybord,
      required this.controller,
      required this.error})
      : super(key: key);
  final String hint;
  final IconData icon;
  final TextInputType keybord;
  final TextEditingController controller;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keybord,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return error;
          }
          return 'Success ';
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(color: primaryColor),
          labelText: hint,
          prefixIcon: Icon(
            icon,
            color: primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),
      ),
    );
  }
}
