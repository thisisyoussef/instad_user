import 'package:flutter/material.dart';

class VenueLocationTile extends StatelessWidget {
  const VenueLocationTile({
    Key key,
    @required this.miniView,
    @required this.venueArea,
    @required this.venueDistance,
    @required this.isTransparent,
  }) : super(key: key);

  final bool miniView;
  final String venueArea;
  final int venueDistance;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (miniView == false) ? 34 : 22,
      width: (miniView == false) ? 154 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color:
            !isTransparent ? const Color(0x9a000000) : const Color(0x67000000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.location_on_outlined,
            color: Colors.white,
          ),
          Text(
            venueArea + ', ' + venueDistance.toString(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: const Color(0xffffffff),
              letterSpacing: 0.96,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
