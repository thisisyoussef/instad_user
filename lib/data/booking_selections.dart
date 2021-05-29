import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingSelections extends ChangeNotifier {
  DateTime _selectedDay;
  List<Timestamp> _selectedBookings = [];
  bool isSelected(Timestamp selectedBooking) {
    return _selectedBookings.contains(selectedBooking);
  }

  void addToBookings(Timestamp selectedBooking) {
    _selectedBookings.add(selectedBooking);
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
}
