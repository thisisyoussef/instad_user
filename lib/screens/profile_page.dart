import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/models/booking.dart';
import 'package:instad_user/screens/bookedPage/booking_details_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class ProfilePage extends StatefulWidget {
  @override
  ProfilePage();
  List<Booking> bookings = [];
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int segmentedControlGroupValue = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> myTabs = <int, Widget>{
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Text(
          'Upcoming',
          style: TextStyle(
            fontFamily: 'Hussar',
            fontSize: 16,
            color: segmentedControlGroupValue != 0
                ? Color(0xFF2B8116)
                : Color(0xffffffff),
            letterSpacing: 0.96,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      1: Text(
        'History',
        style: TextStyle(
          fontFamily: 'Hussar',
          fontSize: 16,
          color: segmentedControlGroupValue != 1
              ? Color(0xFF2B8116)
              : Color(0xffffffff),
          letterSpacing: 0.96,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
/*

*/
    };
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.white.withOpacity(0),
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Hussar',
                    fontSize: 24,
                    color: const Color(0xff2e2e2e),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Color(0xFF707070),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(
                    fontFamily: 'Hussar',
                    fontSize: 18,
                    color: const Color(0xff2e2e2e),
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'name@mail.com',
                  style: TextStyle(
                    fontFamily: 'Hussar',
                    fontSize: 12,
                    color: const Color(0xff2e2e2e),
                    letterSpacing: 0.8,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
              child: Container(
                width: 400,
                child: CupertinoSlidingSegmentedControl(
                    thumbColor: Color(0xFF2B8116),
                    groupValue: segmentedControlGroupValue,
                    children: myTabs,
                    onValueChanged: (i) {
                      setState(() {
                        segmentedControlGroupValue = i;
                      });
                    }),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('bookings')
                .snapshots(),
            builder: (context, snapshot) {
              print(FirebaseAuth.instance.currentUser.uid);
              widget.bookings.clear();
              if (!snapshot.hasData) {
                return Text("No Bookings");
              }
              final fields = snapshot.data.docs;
              for (var field in fields) {
                print("Found a booking");
                if (segmentedControlGroupValue == 1 &&
                    field.data()['endTime'].toDate().isBefore(DateTime.now())) {
                  widget.bookings.add(Booking(
                      phoneNumber: "0xx",
                      endTime: field.data()['endTime'].toDate(),
                      startTime: field.data()['startTime'].toDate(),
                      name: "Placeholder Name",
                      uid: FirebaseAuth.instance.currentUser.uid,
                      price: 200));
                }
                if (segmentedControlGroupValue == 0 &&
                    field.data()['endTime'].toDate().isAfter(DateTime.now())) {
                  widget.bookings.add(Booking(
                      phoneNumber: "0xx",
                      endTime: field.data()['endTime'].toDate(),
                      startTime: field.data()['startTime'].toDate(),
                      name: "Placeholder Name",
                      uid: FirebaseAuth.instance.currentUser.uid,
                      price: 200));
                }
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: widget.bookings.length,
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  itemBuilder: (context, position) {
                    var booking = widget.bookings[position];
                    return BookingDetailsCard(
                      isListview: true,
                      fontScale: 0.8,
                      booking: booking,
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    ));
  }
}
