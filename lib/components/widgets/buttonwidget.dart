import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onClicked;

  // final Colors? colors;
  const ButtonWidget({Key? key, required this.text, this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    onPressed: () {
      return onClicked!();
    },

      color: Colors.cyanAccent,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
      child: Text(
      text,
       style: const TextStyle(color: Colors.white, fontSize: 17),

  ),
  );
  }

