//
// import 'package:flutter/material.dart';
//
//
// class TextFieldWidget extends StatefulWidget {
//   // final userNameEditingController = TextEditingController();
//   final TextEditingController controller = TextEditingController();
//   final IconData? iconData;
//   final TextInputType? textInputType;
//   final String? hintText;
//   final double? borderRadius;
//   final bool obscureText = false;
//
//   TextFieldWidget(
//       {Key? key, this.iconData, this.textInputType, this.hintText, this.borderRadius, controller})
//       : super(key: key);
//
//   @override
//   State<TextFieldWidget> createState() => TextFieldWidgetState();
// }
//
//   class TextFieldWidget extends State<TextFieldWidget> {
//
//     @override
//   Widget build(BuildContext context) {
//   return TextFormField(
//   autofocus: false,
//   controller: controller,
//   obscureText: obscureText,
//   keyboardType: textInputType,
//   validator: (value) {
//   if (value!.isEmpty) {
//   return ("Please Enter Your Email");
//   }
//   // reg expression for email validation
//   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
//       .hasMatch(value)) {
//   return ("Please Enter a valid email");
//   }
//   return null;
//   },
//   onSaved: (value) {
//   controller.text = value!;
//   },
//   textInputAction: TextInputAction.next,
//   decoration: InputDecoration(
//   prefixIcon: Icon(iconData),
//   contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//   hintText: hintText,
//   border: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(borderRadius ?? 0),
//   ),
//   ));
//   }
//
//   }
