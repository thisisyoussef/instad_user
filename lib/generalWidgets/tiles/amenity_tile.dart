import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/string_to_icon_data.dart';

class AmenityTile extends StatelessWidget {
  //const AmenityTile({Key key, this.amentiy}) : super(key: key);
  const AmenityTile(this.amentiy);
  final String amentiy;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0x65d1eacc),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Row(
          children: [
            Icon(
              StringToIconData(amentiy),
              color: const Color(0xff2b8116),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Text(
                amentiy,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: const Color(0xff2b8116),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
