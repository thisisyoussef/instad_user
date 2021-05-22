import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'select_time_button.dart';

class SelectTimeGrid extends StatelessWidget {
  const SelectTimeGrid({
    Key key,
    @required this.isAm,
    @required this.timeslotsAM,
  }) : super(key: key);

  final bool isAm;
  final List<Timestamp> timeslotsAM;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isAm ? 'AM' : 'PM',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            color: const Color(0xff2e2e2e),
            letterSpacing: 0.8,
          ),
          textAlign: TextAlign.left,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                for (int i = 0; i < timeslotsAM.length; i += 3)
                  Padding(
                    padding: EdgeInsets.only(
                        top: i > 2 ? 16.0 : 0, left: 5, right: 5),
                    child: Row(
                      children: [
                        for (int j = i;
                            (j % 3 != 0 && j < timeslotsAM.length) || j == i;
                            j++)
                          SelectTimeButton(
                            timeSlot: timeslotsAM[j],
                            isAm: isAm,
                          ),
                      ],
                    ),
                  ),
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
