import 'package:flutter/material.dart';

class MySubmitButton extends StatelessWidget {
  final double height;
  final Widget widget;
  final double? width;
  final double border;
  final double fontSize;
  final List<Color> colors;
  final String text;
  final Color textColor;
  final Color shadowColor;
  final void Function()? onPressed;

  const MySubmitButton({
    super.key,
    this.height = 50,
    this.border = 12,
    this.width,
    this.fontSize = 20,
    required this.colors,
    required this.text,
    required this.shadowColor,
    this.onPressed,
    required this.textColor,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(colors: colors),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border),
        ), // لجعل الضغطة متناسبة مع انحناء الحواف
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
