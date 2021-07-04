import 'package:flutter/material.dart';
import 'sports_card.dart';
import 'package:instad_user/data/instad_data.dart';

class SportsCardGrid extends StatelessWidget {
  const SportsCardGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: GridView.count(
        childAspectRatio: 158 / 110,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        crossAxisCount: 2,
        crossAxisSpacing: 21,
        mainAxisSpacing: 12,
        children: [
          for (String sport in InstadData.sports)
            SportsCard(
              sport: sport,
            ),
        ],
      ),
    );
  }
}
