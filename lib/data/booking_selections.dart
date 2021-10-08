import 'package:flutter/cupertino.dart';
import 'package:instad_user/functions/merge_date_time.dart';
import 'package:instad_user/models/booking.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;

class BookingSelections extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  String latestBookingId;
  Booking latestBooking;
  List<Timestamp> _selectedBookings = [];
  bool isSelected(Timestamp selectedBooking) {
    //selectedBooking = mergeDayTime(selectedBooking, _selectedDay);
    return _selectedBookings.contains(selectedBooking);
  }

  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  DateTime getSelectedDay() {
    return _selectedDay;
  }

  String getLatestBookingId() {
    return latestBookingId;
  }

  Booking getLatestBooking() {
    return latestBooking;
  }

  void clearSelections() {
    _selectedBookings.clear();
    notifyListeners();
  }

  void addToBookings(Timestamp selectedBooking) {
    //selectedBooking = mergeDayTime(selectedBooking, _selectedDay);
    _selectedBookings.add(selectedBooking);
    _selectedBookings.sort();
    notifyListeners();
  }

  void removeFromBookings(Timestamp selectedBooking) {
    //selectedBooking = mergeDayTime(selectedBooking, _selectedDay);
    _selectedBookings.remove(selectedBooking);
    notifyListeners();
  }

  bool timeslotSelected() {
    return !_selectedBookings.isEmpty;
  }

  List<int> getBookings() {
    List<int> bookings = [];
    for (var booking in _selectedBookings) {
      bookings.add(booking.toDate().hour);
    }
    return bookings;
  }

  void bookVenue(String venueId, UserDetails userDetails) {
    //print("logged in user: " + UserDetails().loggedInUserID);
    _firestore.collection('locations').doc(venueId).update({
      "bookedSlots": FieldValue.arrayUnion(_selectedBookings),
    });
    if (_selectedBookings.length > 0) {
      _firestore
          .collection("locations")
          .doc(venueId)
          .collection("bookings")
          .add({
        'bookingName': userDetails.userName,
        'phoneNumber': userDetails.userNumber,
        'startTime': _selectedBookings[0],
        'endTime': Timestamp.fromDate(
            _selectedBookings[_selectedBookings.length - 1]
                .toDate()
                .add(Duration(hours: 1))),
        'userId': FirebaseAuth.instance.currentUser.uid,
        'price': _selectedBookings.length * 200
      });
      _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("bookings")
          .add({
        'bookingName': userDetails.userName,
        'phoneNumber': userDetails.userNumber,
        'startTime': _selectedBookings[0],
        'endTime': Timestamp.fromDate(
            _selectedBookings[_selectedBookings.length - 1]
                .toDate()
                .add(Duration(hours: 1))),
        'location': venueId,
        'price': _selectedBookings.length * 200,
      }).then((value) => latestBookingId = value.id);
      latestBooking = Booking(
          phoneNumber: userDetails.userNumber,
          name: UserDetails().userName,
          startTime: DateTime.fromMicrosecondsSinceEpoch(
              _selectedBookings[0].microsecondsSinceEpoch),
          isAllDay: false,
          price: _selectedBookings.length * 200,
          endTime: DateTime.fromMicrosecondsSinceEpoch(
              (_selectedBookings[_selectedBookings.length - 1])
                      .microsecondsSinceEpoch +
                  3600000000));
    }
  }
}
