import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/sport_as_icon_data.dart';

class SportIcon extends StatelessWidget {
  final String sport;
  SportIcon(this.sport);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0x9a000000),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          SportAsIconData(sport),
          color: Colors.white,
        ),
      ),
    );
  }
}
