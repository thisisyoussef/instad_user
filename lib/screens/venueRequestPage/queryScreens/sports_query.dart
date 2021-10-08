import 'package:flutter/material.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/screens/filterModal/filter_title_bar.dart';
import 'package:instad_user/screens/homeScreen/sportsCardGrid/sports_card_grid.dart';
import 'package:provider/provider.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterTitleBar(
              cancelCallBack: () {
                Navigator.pop(context);
              },
              saveCallBack: () {
                Provider.of<VenueFilters>(context, listen: false)
                    .setSelectedSport(
                        Provider.of<VenueFilters>(context, listen: false)
                            .getUnappliedSport());
                Navigator.pop(context);
              },
              title: "Sport",
              hasReset: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 24, bottom: 8),
              child: Text(
                'Select a sport to play',
                style: TextStyle(
                  fontFamily: 'Hussar',
                  fontSize: 14,
                  color: const Color(0xff2e2e2e),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SportsCardGrid(
              isFilterVersion: true,
            )
          ],
        ),
      ),
    );
  }
}
