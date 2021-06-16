import 'package:flutter/material.dart';
import 'booking_details_card.dart';

class BookedPage extends StatelessWidget {
  static String id = "booked_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BookingDetailsCard(
              isListview: false,
            ),
          ),
        ));
  }
}
