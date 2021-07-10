import 'package:flutter/material.dart';

class WideRoundedButton extends StatelessWidget {
  WideRoundedButton(
      {this.color, this.title, this.onPressed, this.textColor, this.isEnabled});
  final Color color;
  final String title;
  final Function onPressed;
  final textColor;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Container(
            height: 48,
            width: 327,
            decoration: BoxDecoration(
              color: isEnabled
                  ? color != null
                      ? color
                      : Color(0xFFC7C7C7)
                  : null,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              gradient: isEnabled && color == null
                  ? LinearGradient(
                      colors: [Color(0xFF2CA387), Color(0xFF2B8116)],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft)
                  : null,
            ),
            child: MaterialButton(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: isEnabled ? Colors.white : const Color(0xff707070),
                  letterSpacing: 2.24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
