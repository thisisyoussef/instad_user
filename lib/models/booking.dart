import 'package:flutter/material.dart';

class Booking {
  final String name;
  final String phoneNumber;
  final String uid;
  DateTime startTime;
  DateTime endTime;
  Color background = Color(0xFF50B184);
  bool isRecurring = false;
  bool isAllDay = false;
  Booking(
      {this.name,
      this.phoneNumber,
      this.startTime,
      this.endTime,
      this.uid,
      @required this.isAllDay,
      @required this.isRecurring});
}
