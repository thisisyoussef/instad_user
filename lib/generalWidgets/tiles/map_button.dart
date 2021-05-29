import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    Key key,
    this.miniView,
  }) : super(key: key);
  final bool miniView;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !miniView
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Map',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: const Color(0xff2b8116),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.map_outlined,
                      color: Color(0xFF2B8116),
                    ),
                  )
                ],
              ))
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.zoom_out_map,
                color: Color(0xFF2B8116),
                size: 28,
              ),
            ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(1, 2),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }
}
