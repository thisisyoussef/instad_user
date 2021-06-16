import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;

class BookingSelections extends ChangeNotifier {
  DateTime _selectedDay;
  List<Timestamp> _selectedBookings = [];
  bool isSelected(Timestamp selectedBooking) {
    return _selectedBookings.contains(selectedBooking);
  }

  void clearSelections() {
    _selectedBookings.clear();
    notifyListeners();
  }

  void addToBookings(Timestamp selectedBooking) {
    _selectedBookings.add(selectedBooking);
    _selectedBookings.sort();
    notifyListeners();
  }

  void removeFromBookings(Timestamp selectedBooking) {
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

  void bookVenue(String venueId) {
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
        'bookingName': UserDetails().userName,
        'phoneNumber': UserDetails().userNumber,
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
        'bookingName': UserDetails().userName,
        'phoneNumber': UserDetails().userNumber,
        'startTime': _selectedBookings[0],
        'endTime': Timestamp.fromDate(
            _selectedBookings[_selectedBookings.length - 1]
                .toDate()
                .add(Duration(hours: 1))),
        'location': venueId,
        'price': _selectedBookings.length * 200,
      });
    }
  }
}
