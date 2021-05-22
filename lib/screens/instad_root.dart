import 'dart:math';
import 'package:flutter/material.dart';
import 'package:instad_user/screens/homeScreen/home_page.dart';
import 'package:instad_user/screens/map_screen.dart';
import 'package:instad_user/screens/venuesScreen/venues_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';

final _firestore = FirebaseFirestore.instance;
List<ListCard> listCards = [];

class InstadRoot extends StatefulWidget {
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
        for (var field in fields) {
          final bool approved = field.data()['approved'];
          final String Id = field.id;
          final String name = field.data()['name'];
          final String area = field.data()['Area'];
          final double rating = field.data()['Rating'];
          final List sports = field.data()['Sports'];
          final int price = field.data()["price"];
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
          listCards.add(listCard);
        }
        return homePage == false
            ? VenuesScreen(listCards)
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
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          VenueListStream(homePage: true),
          VenueListStream(
            homePage: false,
          ),
          MapScreen(),
          Container(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }
}
