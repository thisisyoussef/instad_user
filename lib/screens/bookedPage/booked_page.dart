import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'package:instad_user/models/booking.dart';
import 'booking_details_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BookedPage extends StatelessWidget {
  static String id = "booked_page";
  final Booking booking;
  const BookedPage({Key key, this.booking}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BookingDetailsCard(
                isListview: false,
                booking: booking,
              ),
            ),
          ),
        ));
  }
}
