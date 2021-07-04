import 'package:flutter/material.dart';
import 'package:instad_user/screens/filterModal/filter_title_bar.dart';
import 'package:instad_user/screens/homeScreen/sportsCardGrid/sports_card_grid.dart';

class SportsQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF000000).withOpacity(0.5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            FilterTitleBar(
              title: "Sport",
              hasReset: false,
            ),
            SportsCardGrid()
          ],
        ),
      ),
    );
  }
}
