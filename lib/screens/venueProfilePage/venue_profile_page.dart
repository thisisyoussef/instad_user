import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:instad_user/generalWidgets/slider_widget.dart';
import 'package:instad_user/generalWidgets/tiles/rating_tile.dart';
import 'package:instad_user/generalWidgets/tiles/sports_tile_row.dart';
import 'package:instad_user/generalWidgets/tiles/venue_location_tile.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/services//venue_details.dart';
import 'package:instad_user/generalWidgets/size_provider_widget.dart';
import 'package:instad_user/generalWidgets/image_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'venue_page_header.dart';
import 'select_time_grid.dart';

class VenueProfilePage extends StatefulWidget {
  static String id = "venue_page";
  final Widget venueImage;

  const VenueProfilePage({Key key, this.venueImage}) : super(key: key);

  @override
  _VenueProfilePageState createState() => _VenueProfilePageState();
}

class _VenueProfilePageState extends State<VenueProfilePage> {
  static List sports = [
    "Football",
    "Basketball",
    "Padel Tennis",
  ];
  List<Timestamp> timeslotsAM = [
    Timestamp.now(),
    Timestamp.now(),
    Timestamp.now()
  ];
  List<Timestamp> timeslotsPM = [
    Timestamp.now(),
    Timestamp.now(),
    Timestamp.now(),
    Timestamp.now(),
    Timestamp.now(),
    Timestamp.now(),
    Timestamp.now(),
  ];
  bool isAm = true;

  bool isFavorite = true;
  var _currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF7F8F8),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 50,
              expandedHeight: 227,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: VenuePageHeader(venueImage: widget.venueImage),
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VenueInfo(sports: sports),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Row(
                      children: [
                        Text(
                          '200 ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            color: const Color(0xff2e2e2e),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "EGP/ Hour",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17,
                            color: const Color(0xff2e2e2e),
                            letterSpacing: 0.96,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'SELECT TIME',
                      style: TextStyle(
                        fontFamily: 'Chakra Petch',
                        fontSize: 18,
                        color: const Color(0xff2b8116),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SelectTimeGrid(isAm: true, timeslotsAM: timeslotsAM),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child:
                        SelectTimeGrid(isAm: false, timeslotsAM: timeslotsPM),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class VenueInfo extends StatelessWidget {
  const VenueInfo({
    Key key,
    @required this.sports,
  }) : super(key: key);

  final List sports;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hayah International Academy',
          style: TextStyle(
            fontFamily: 'Chakra Petch',
            fontSize: 24,
            color: const Color(0xff2e2e2e),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              VenueLocationTile(
                miniView: false,
                venueArea: "Tagamoa",
                venueDistance: 5,
                isTransparent: false,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RatingTile(
                  miniView: false,
                  venueRating: 4.2,
                  transparent: false,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: SportsTileRow(venueSports: sports),
        ),
      ],
    );
  }
}
