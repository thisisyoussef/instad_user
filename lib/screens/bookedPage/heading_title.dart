import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  HeadingTitle({
    Key key,
    @required this.heading,
    @required this.title,
    @required this.fontScale,
  }) : super(key: key);

  final String heading;
  final String title;
  final double fontScale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20 * this.fontScale,
            color: const Color(0xff2e2e2e),
            letterSpacing: 0.8,
          ),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 25 * this.fontScale,
              color: const Color(0xff2e2e2e),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
