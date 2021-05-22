import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/tiles/venue_location_tile.dart';
import 'package:instad_user/generalWidgets/tiles/rating_tile.dart';

class VenueImageCard extends StatelessWidget {
  final Widget venueImage;
  final String venueName;
  final String venueArea;
  final double venueRating;
  final int venueDistance;
  final int venuePrice;
  final bool miniView;
  VenueImageCard({
    this.venueImage,
    this.venueName,
    this.venueArea,
    this.venueRating,
    this.venueDistance,
    this.venuePrice,
    this.miniView,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        venueImage,
        (miniView == false)
            ? Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 15),
                  child: VenueLocationTile(
                    miniView: miniView,
                    venueArea: venueArea,
                    venueDistance: venueDistance,
                    isTransparent: true,
                  ),
                ),
              )
            : Container(),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
                top: 5.0,
                right: (miniView == false) ? 15 : 0,
                left: (miniView == false) ? 30 : 140),
            child: RatingTile(
              miniView: miniView,
              venueRating: venueRating,
              transparent: true,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 0.0,
                left: (miniView == false) ? 15 : 0,
                right: (miniView == false) ? 15 : 0),
            child: Container(
              height: 34,
              width:
                  (miniView == false) ? MediaQuery.of(context).size.width : 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0x67000000),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4),
                child: Text(
                  venueName,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: (miniView == false) ? 16 : 12,
                    color: const Color(0xffffffff),
                    letterSpacing: 0.96,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
