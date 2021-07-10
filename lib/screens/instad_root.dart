import 'dart:math';
import 'package:flutter/material.dart';
import 'package:instad_user/functions/build_listCards.dart';
import 'package:instad_user/screens/homeScreen/home_page.dart';
import 'package:instad_user/screens/map_screen.dart';
import 'package:instad_user/screens/profile_page.dart';
import 'package:instad_user/screens/venueRequestPage/venue_request_page.dart';
import 'package:instad_user/screens/venuesScreen/venues_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'package:instad_user/models/venue_list.dart';
import 'package:instad_user/models/venue.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/models/booking.dart';
import 'package:instad_user/models/timeslot.dart';

final _firestore = FirebaseFirestore.instance;
List<ListCard> listCards = [];

class InstadRoot extends StatefulWidget {
  static GlobalKey InstadRootStateKey = new GlobalKey<_InstadRootState>();
  static TabController tabController;

  static String id = "home_screen";
  @override
  _InstadRootState createState() => _InstadRootState();
}

/*
StreamBuilder<QuerySnapshot> buildStreamBuilder(bool homePage) {
  return VenueListStream();
}
*/

class VenueListStream extends StatelessWidget {
  const VenueListStream({Key key, this.homePage}) : super(key: key);

  final bool homePage;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('locations').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final fields = snapshot.data.docs;
        listCards.clear();
        Provider.of<VenueList>(context, listen: false).venues.clear();

        for (var field in fields) {
          final bool approved = field.data()['approved'];
          final String Id = field.id;
          final String name = field.data()['name'];
          final String area = field.data()['Area'];
          final double rating = field.data()['Rating'];
          final List sports = field.data()['Sports'];
          final double truePrice = field.data()['price'];
          final int price = truePrice.toInt();
          print("Price is " + price.toString());
          double latitude;
          double longitude;
          final listCard = ListCard(
            venueArea: area,
            venueDistance: 5,
            venueRating: rating,
            venueId: Id,
            venueName: name,
            approved: approved,
            venueSports: sports,
            venuePrice: price,
          );
          final venue = Venue(
            venueArea: area,
            venueDistance: 5,
            venueRating: rating,
            venueId: Id,
            venueName: name,
            venueSports: sports,
            venuePrice: price,
          );
          //listCards.add(listCard);
          if (Provider.of<VenueList>(context, listen: false).venues == null ||
              !Provider.of<VenueList>(context, listen: false).inList(venue)) {
            Provider.of<VenueList>(context, listen: false).addVenue(venue);
          }
        }

        for (var venue
            in Provider.of<VenueList>(context, listen: false).venues) {
          if (listCards == null || !listCards.contains(venue)) {
            final listCard = ListCard(
              venueArea: venue.venueArea,
              venueDistance: venue.venueDistance,
              venueRating: venue.venueRating,
              venueId: venue.venueId,
              venueName: venue.venueName,
              venueSports: venue.venueSports,
              venuePrice: venue.venuePrice,
            );
            listCards.add(listCard);
          }
        }

        return homePage == false
            ? VenuesScreen(/*listCards*/)
            : HomePage(listCards);
      },
    );
  }
}

class _InstadRootState extends State<InstadRoot> with TickerProviderStateMixin {
  static const tabs = <Tab>[
    Tab(
//      icon: ,
      child: Icon(
        Icons.house_outlined,
        color: Colors.black,
        size: 30,
      ),
    ),
    Tab(
      child: Icon(
        Icons.bookmark_border,
        color: Colors.black,
        size: 30,
      ),
    ),
    Tab(
      child: Icon(
        Icons.location_on_outlined,
        color: Colors.black,
        size: 30,
      ),
    ),
    Tab(
//      icon: ,
      child: Icon(
        Icons.account_circle_outlined,
        color: Colors.black,
        size: 30,
      ),
    ),
  ];
  @override
  void initState() {
    _firestore.collection('locations').get().then((querySnapshot) {
      querySnapshot.docs.forEach((location) {
        final bool approved = location.data()['approved'];
        final String Id = location.id;
        final String name = location.data()['name'];
        final String area = location.data()['Area'];
        final double rating = location.data()['Rating'];
        final List sports = location.data()['Sports'];
        final int price = location.data()['price'];
        final List amenities = location.data()['amenities'];
        final GeoPoint geoPoint = location.data()['location'];
        //final int price = truePrice.toInt();
        print("Location is " + geoPoint.toString());
        final venue = Venue(
          venueArea: area,
          venueDistance: 5,
          venueRating: rating,
          venueId: Id,
          venueName: name,
          venueSports: sports,
          venuePrice: price,
          location: geoPoint,
          venueAmenities: amenities,
        );
        if (Provider.of<VenueList>(context, listen: false).venues == null ||
            !Provider.of<VenueList>(context, listen: false).inList(venue)) {
          Provider.of<VenueList>(context, listen: false).addVenue(venue);
        }
      });

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
          );
          listCards.add(listCard);
        }
      }
    });
    InstadRoot.tabController = TabController(length: tabs.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: InstadRoot.tabController,
        children: <Widget>[
          HomePage(listCards),
          VenueRequestPage(),
          MapScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: InstadRoot.tabController,
          tabs: tabs,
        ),
      ),
    );
  }
}
