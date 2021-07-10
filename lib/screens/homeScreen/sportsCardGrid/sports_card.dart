import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/string_to_icon_data.dart';
import 'package:instad_user/screens/instad_root.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/data/venue_filters.dart';

class SportsCard extends StatelessWidget {
  const SportsCard({Key key, this.sport, this.isFilterVersion})
      : super(key: key);
  final String sport;
  final bool isFilterVersion;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isFilterVersion
            ? Provider.of<VenueFilters>(context, listen: false)
                .setUnappliedSport(sport)
            : Provider.of<VenueFilters>(context, listen: false)
                .setSelectedSport(sport);
        InstadRoot.tabController.animateTo(1);
      },
      child: Container(
        //height: 110,
        //width: 158,

        decoration: isFilterVersion &&
                Provider.of<VenueFilters>(context, listen: true)
                        .getUnappliedSport() !=
                    sport
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xffb6cda4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(1, 2),
                    blurRadius: 6,
                  ),
                ],
              )
            : BoxDecoration(
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
      ),
    );
  }
}
