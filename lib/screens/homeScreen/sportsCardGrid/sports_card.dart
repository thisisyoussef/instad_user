import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/string_to_icon_data.dart';

class SportsCard extends StatelessWidget {
  const SportsCard({Key key, this.sport}) : super(key: key);
  final String sport;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 110,
      //width: 158,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment(1.0, 1.0),
          end: Alignment(-1.0, -1.0),
          colors: [const Color(0xff548b46), const Color(0xffaacc88)],
          stops: [0.0, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(1, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Icon(
              StringToIconData(sport),
              color: Colors.white,
              size: 60,
            ),
          ),
          Text(
            sport,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
