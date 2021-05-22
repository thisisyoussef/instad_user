import 'package:flutter/material.dart';

class RatingTile extends StatelessWidget {
  const RatingTile(
      {Key key,
      @required this.miniView,
      @required this.venueRating,
      @required this.transparent})
      : super(key: key);

  final bool miniView;
  final double venueRating;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: !transparent ? const Color(0x9a000000) : const Color(0x67000000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.star,
            color: Color(0xFFF5DA00),
            size: (miniView == false) ? 24 : 20,
          ),
          Text(
            venueRating.toString(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: (miniView == false) ? 16 : 12,
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
