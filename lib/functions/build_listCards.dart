import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'package:instad_user/models/venue_list.dart';

void buildListCards(BuildContext context, List<ListCard> listCards) {
  listCards.clear();
  for (var venue in Provider.of<VenueList>(context, listen: false).venues) {
    if (listCards == null || !listCards.contains(venue)) {
      final listCard = ListCard(
        venueArea: venue.venueArea,
        venueDistance: venue.venueDistance,
        venueRating: venue.venueRating,
        venueId: venue.venueId,
        venueName: venue.venueName,
        venueSports: venue.venueSports,
        venuePrice: venue.venuePrice,
        location: venue.location,
        venueAmenities: venue.venueAmenities,
      );
      listCards.add(listCard);
    }
  }
}
