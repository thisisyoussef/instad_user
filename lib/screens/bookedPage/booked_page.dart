import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'package:instad_user/models/booking.dart';
import 'booking_details_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BookedPage extends StatelessWidget {
  static String id = "booked_page";

  const BookedPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Booking booking;
    final _firestore = FirebaseFirestore.instance;
    final field = _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("bookings")
        .doc(Provider.of<BookingSelections>(context, listen: true)
            .getLatestBooking())
        .get()
        .then((querySnapshot) {
      booking = Booking(
        name: querySnapshot.data()['bookingName'],
        startTime: querySnapshot.data()['startTime'],
        endTime: querySnapshot.data()['endTime'],
      );
    });
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BookingDetailsCard(
              isListview: false,
              booking: booking,
            ),
          ),
        ));
  }
}
