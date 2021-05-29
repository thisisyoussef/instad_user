import 'package:cloud_firestore/cloud_firestore.dart';

class Timeslot {
  Timeslot({this.booked, this.time});
  final bool booked;
  final Timestamp time;
}
