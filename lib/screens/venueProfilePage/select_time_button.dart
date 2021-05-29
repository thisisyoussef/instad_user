import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'package:instad_user/models/timeslot.dart';
import 'package:provider/provider.dart';

class SelectTimeButton extends StatelessWidget {
  SelectTimeButton({this.timeSlot, this.isAm});
  final Timeslot timeSlot;
  final bool isAm;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Provider.of<BookingSelections>(context, listen: true)
                        .isSelected(timeSlot.time)
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : !timeSlot.booked
                        ? Icon(
                            Icons.add,
                            color: const Color(0xff2b8116),
                          )
                        : Container(),
                Padding(
                  padding: EdgeInsets.only(left: isAm ? 0.0 : 8.0),
                  child: Text(
                    (!isAm
                            ? timeSlot.time.toDate().hour - 12
                            : timeSlot.time.toDate().hour)
                        .toString(),
                    style: Provider.of<BookingSelections>(context, listen: true)
                            .isSelected(timeSlot.time)
                        ? TextStyle(
                            fontFamily: 'Helvetica Neue',
                            fontSize: 20,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          )
                        : !timeSlot.booked
                            ? TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 20,
                                color: const Color(0xff2b8116),
                                fontWeight: FontWeight.w700,
                              )
                            : TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 20,
                                color: const Color(0x342e2e2e),
                                fontWeight: FontWeight.w700,
                              ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    isAm ? 'AM' : 'PM',
                    style: Provider.of<BookingSelections>(context, listen: true)
                            .isSelected(timeSlot.time)
                        ? TextStyle(
                            fontFamily: 'Helvetica Neue',
                            fontSize: 14,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          )
                        : !timeSlot.booked
                            ? TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 14,
                                color: const Color(0xff2b8116),
                                //fontWeight: FontWeight.w300,
                              )
                            : TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 14,
                                color: const Color(0x342e2e2e),
                                fontWeight: FontWeight.w300,
                              ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          decoration: !Provider.of<BookingSelections>(context, listen: true)
                  .isSelected(timeSlot.time)
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: !timeSlot.booked
                      ? const Color(0xffffffff)
                      : const Color(0xFFF0F0F0),
                  border: !timeSlot.booked
                      ? Border.all(
                          width: !timeSlot.booked ? 1.0 : 1,
                          color: !timeSlot.booked
                              ? const Color(0xff2b8116)
                              : const Color(0xFF707070))
                      : null,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0xff2b8116),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(1, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
        ),
        onTap: () {
          if (!timeSlot.booked) {
            if (Provider.of<BookingSelections>(context, listen: false)
                .isSelected(timeSlot.time)) {
              Provider.of<BookingSelections>(context, listen: false)
                  .removeFromBookings(timeSlot.time);
            } else {
              Provider.of<BookingSelections>(context, listen: false)
                  .addToBookings(timeSlot.time);
            }
          }
        },
      ),
    );
    ;
  }
}
