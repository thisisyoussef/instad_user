import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instad_user/models/venue.dart';
import 'package:instad_user/models/venue_list.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'package:provider/provider.dart';

import 'instad_root.dart';
import 'loginScreen/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  static String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
        upperBound: 1,
        lowerBound: 0.2);
    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutCubicEmphasized);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        //addVenuesThenList();
      } else if (status == AnimationStatus.dismissed) {
        // Navigator.popAndPushNamed(context, LoginPage.id);
        controller.forward();
      }
    });
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
        print(name);
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
        if (Provider.of<VenueList>(context, listen: false).getVenues() ==
                null ||
            !Provider.of<VenueList>(context, listen: false).inList(venue)) {
          Provider.of<VenueList>(context, listen: false).addVenue(venue);
        }
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 2), () {
        User currentUser = _auth.currentUser;
        if (currentUser == null) {
          Navigator.popAndPushNamed(context, LoginPage.id);
          // No user is signed in
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => InstadRoot(),
            ),
          ); // User logged in
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                  'assets/images/3x/instad green circle circle@3x.png'),
              height: animation.value * 170,
            ),
            /*Container(
              child: Image.asset(
                'assets/images/logoBlack.png',
                opacity: AlwaysStoppedAnimation<double>(animation.value),
              ),
              height: 100,
            ),*/
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    listCards.clear();
    //Provider.of<VenueList>(context, listen: false).venues.clear();
    for (var venue
        in Provider.of<VenueList>(context, listen: true).getVenues()) {
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
      //print("Adding " + listCard.venueName);
      setState(() {
        listCards.add(listCard);
      });
    }

    super.didChangeDependencies();
  }

  void addVenuesThenList() async {
    listCards.clear();
    //Provider.of<VenueList>(context, listen: false).venues.clear();
    for (var venue
        in Provider.of<VenueList>(context, listen: true).getVenues()) {
      await _firestore.collection('locations').get().then((querySnapshot) {
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
          print(name);
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
          if (Provider.of<VenueList>(context, listen: false).getVenues() ==
                  null ||
              !Provider.of<VenueList>(context, listen: false).inList(venue)) {
            Provider.of<VenueList>(context, listen: false).addVenue(venue);
          }
        });
      });
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
      //print("Adding " + listCard.venueName);
      setState(() {
        listCards.add(listCard);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();

    super.dispose();
  }
}
