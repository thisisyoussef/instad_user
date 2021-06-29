import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'select_time_button.dart';
import 'package:instad_user/generalWidgets/tiles/amenity_tile.dart';

class SelectTimeGrid extends StatelessWidget {
  const SelectTimeGrid({
    Key key,
    @required this.isAm,
    @required this.childrenList,
    @required this.isAmenitiesGrid,
  }) : super(key: key);
  final bool isAm;
  final List childrenList;
  final bool isAmenitiesGrid;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          !isAmenitiesGrid
              ? isAm
                  ? 'AM'
                  : 'PM'
              : "",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            color: const Color(0xff2e2e2e),
            letterSpacing: 0.8,
          ),
          textAlign: TextAlign.left,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4),
            child: isAmenitiesGrid
                ? Wrap(
                    spacing: isAmenitiesGrid ? 10 : 4,
                    runSpacing: isAmenitiesGrid ? 10 : 12,
                    children: [
                      for (int i = 0; i < childrenList.length; i++)
                        isAmenitiesGrid
                            ? AmenityTile(childrenList[i].toString())
                            : SelectTimeButton(
                                timeSlot: childrenList[i],
                                isAm: isAm,
                              ),
                    ],
                  )
                : Table(
                    children: <TableRow>[
                      for (int i = 0; i < childrenList.length; i += 3)
                        TableRow(children: <Widget>[
                          for (int j = i; (j % 3 != 0 || j == i); j++)
                            TableCell(
                              child: j < childrenList.length
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: SelectTimeButton(
                                        timeSlot: childrenList[j],
                                        isAm: isAm,
                                      ),
                                    )
                                  : Container(
                                      width: 110,
                                    ),
                            ),
                        ])
                    ],
                  ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.0),
            color: const Color(0xffffffff),
          ),
        ),
      ],
    );
  }
}
