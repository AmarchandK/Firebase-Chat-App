
import 'package:chat_firebase/helper/helpers.dart';
import 'package:flutter/material.dart';

class OnTapButton extends StatelessWidget {
  const OnTapButton({
    Key? key,
    required this.buttonName,
    this.onPressed
  }) : super(key: key);

  final String buttonName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
    );
  }
}