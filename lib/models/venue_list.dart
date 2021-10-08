import 'package:flutter/cupertino.dart';

import 'venue.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';

List<Venue> venues = [];
List<ListCard> listCards = [];

class VenueList extends ChangeNotifier {
  VenueList();

  void addVenue(Venue venue) {
    venues.add(venue);
    notifyListeners();
  }

  void removeVenue(Venue venue) {
    venues.remove(venue);
    notifyListeners();
  }

  List<Venue> getVenues() {
    return venues;
  }

  bool inList(Venue venue) {
    return venues.contains(venue);
  }
}
