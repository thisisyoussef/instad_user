import 'package:cloud_firestore/cloud_firestore.dart';

Timestamp mergeDayTime(Timestamp selectedBooking, DateTime selectedDay) {
  var date = new DateTime.fromMicrosecondsSinceEpoch(
      selectedBooking.microsecondsSinceEpoch);
  DateTime newDateTime =
      DateTime(selectedDay.year, selectedDay.month, selectedDay.day, date.hour);
  Timestamp adjustedBooking = Timestamp.fromDate(newDateTime);
  return adjustedBooking;
}
