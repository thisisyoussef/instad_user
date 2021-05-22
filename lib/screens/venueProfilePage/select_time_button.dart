import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectTimeButton extends StatelessWidget {
  const SelectTimeButton({
    Key key,
    @required this.timeSlot,
    @required this.isAm,
  }) : super(key: key);

  final Timestamp timeSlot;
  final bool isAm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: const Color(0xff2b8116),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  (timeSlot.toDate().hour > 12
                          ? timeSlot.toDate().hour - 12
                          : timeSlot.toDate().hour)
                      .toString(),
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 20,
                    color: const Color(0xff2b8116),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  isAm ? 'AM' : 'PM',
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 14,
                    color: const Color(0xff2b8116),
                    //fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xff2b8116)),
        ),
      ),
    );
  }
}
