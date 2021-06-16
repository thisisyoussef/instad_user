import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key key,
    @required this.headerText,
  }) : super(key: key);

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: TextStyle(
        fontFamily: 'Chakra Petch',
        fontSize: 18,
        color: const Color(0xff2b8116),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }
}
