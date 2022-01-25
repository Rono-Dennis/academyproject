import 'package:flutter/material.dart';

import 'buttonwidget.dart';
class PageViewerWidget extends StatefulWidget {

  final VoidCallback onTap, onClicked;
  final String text1,text2,text3, text4, text5;
  final String image;
  const PageViewerWidget({Key? key, required this.onTap, required this.text1, required this.onClicked, required this.image, required this.text2, required this.text3, required this.text4, required this.text5, }) : super(key: key);

  @override
  _PageViewerWidgetState createState() => _PageViewerWidgetState();
}

class _PageViewerWidgetState extends State<PageViewerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         SizedBox(
          height: 72,
          child: Text(widget.text1,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              )),
        ),
        const SizedBox(
          height: 28,
        ),
        Image.asset(
          "assets/"+ widget.image,
          fit: BoxFit.contain,
        ),

        const SizedBox(
          height: 72,
        ),

         Text(widget.text2,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            )),

        const SizedBox(
          height: 22,
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 49),
          child: Text(
              widget.text3,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              )),
        ),

        const SizedBox(
          height: 32,
        ),

        ButtonWidget(
          text: widget.text4,
          onClicked: widget.onClicked,
              // () => pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.bounceInOut),
        ),

        const SizedBox(
          height: 42,
        ),
        GestureDetector(
          onTap: widget.onTap,

          child:  Text(widget.text5,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,

              )
          ),
        ),
      ],
    );
  }
}
