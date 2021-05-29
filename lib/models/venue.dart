import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instad_user/models/timeslot.dart';

import 'booking.dart';

class Venue {
  Venue({
    this.venueSports,
    this.sports,
    this.venueId,
    this.venueArea,
    this.venueRating,
    this.venuePrice,
    this.venueName,
    this.venueDistance,
    this.openHours,
    this.noOfFields,
    this.location,
    this.venueAmenities,
  });
  String venueName;
  String venueArea;
  double venueRating;
  int venueDistance;
  String venueId;
  List venueSports;
  int venuePrice;
  int noOfFields;
  List sports;
  List openHours = ["12:00", "24:00"];
  GeoPoint location;
  List venueAmenities;
}
