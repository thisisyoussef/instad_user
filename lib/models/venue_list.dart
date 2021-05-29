import 'package:flutter/cupertino.dart';

import 'venue.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';

class VenueList extends ChangeNotifier {
  VenueList();
  List<Venue> venues= [];
  List<ListCard> listCards;

  void addVenue(Venue venue) {
    venues.add(venue);
    notifyListeners();
  }

  void removeVenue(Venue venue) {
    venues.remove(venue);
    notifyListeners();
  }

  bool inList(Venue venue) {
    return venues.contains(venue);
  }
}
