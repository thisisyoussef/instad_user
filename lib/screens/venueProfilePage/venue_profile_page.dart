import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/tiles/map_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'venue_page_header.dart';
import 'select_time_grid.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:instad_user/models/timeslot.dart';
import 'venue_bottom_sheet.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'venue_info.dart';
import 'header_text.dart';
import 'package:provider/provider.dart';

class VenueProfilePage extends StatefulWidget {
  static String id = "venue_page";
  final Widget venueImage;
  final String venueName;
  final String venueArea;
  final double venueRating;
  final int venueDistance;
  final bool approved;
  final String venueId;
  final List venueSports;
  final int venuePrice;
  final GeoPoint location;
  final List venueAmenities;
  const VenueProfilePage({
    Key key,
    this.venueImage,
    this.venueId,
    this.approved,
    this.venueName,
    this.venueArea,
    this.venueRating,
    this.venueDistance,
    this.venueSports,
    this.venuePrice,
    this.location,
    this.venueAmenities,
  }) : super(key: key);

  @override
  _VenueProfilePageState createState() => _VenueProfilePageState();
}

final _firestore = FirebaseFirestore.instance;

class VenueListStream extends StatelessWidget {
  const VenueListStream({Key key, this.homePage}) : super(key: key);

  final bool homePage;
  @override
  Widget build(BuildContext context) {}
}

class _VenueProfilePageState extends State<VenueProfilePage> {
  static List sports = [
    "Football",
    "Basketball",
    "Padel Tennis",
  ];
  List<Timeslot> timeslotsAM = [];
  List<Timeslot> timeslotsPM = [];
  String headerText = "AMENITIES";
  List<String> amenities = [
    "Ball",
    "Bibs",
    "Bathroom",
    "Drinks",
    "Prayer Area",
  ];
  bool isAm = true;

  bool isFavorite = true;
  var _currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          _firestore.collection('locations').doc(widget.venueId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        timeslotsPM.clear();
        timeslotsAM.clear();
        final field = snapshot.data;
        final List timeslots = field.data()['timeSlots'];
        final List bookedslots = field.data()['bookedSlots'];
        timeslots.sort();
        bookedslots.sort();
        for (Timestamp timeslot in timeslots) {
          bool _booked = false;
          if (bookedslots.contains(timeslot)) {
            _booked = true;
          }
          if (timeslot.toDate().isBefore(
                DateTime(timeslot.toDate().year, timeslot.toDate().month,
                    timeslot.toDate().day, 12),
              )) {
            timeslotsAM.add(Timeslot(booked: _booked, time: timeslot));
          } else {
            timeslotsPM.add(Timeslot(booked: _booked, time: timeslot));
          }
        }
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
                      VenueInfo(
                        sports: widget.venueSports,
                        area: widget.venueArea,
                        name: widget.venueName,
                        distance: widget.venueDistance,
                        rating: widget.venueRating,
                        price: widget.venuePrice,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: HeaderText(headerText: "SELECT TIME")),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SelectTimeGrid(
                          isAm: true,
                          childrenList: timeslotsAM,
                          isAmenitiesGrid: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SelectTimeGrid(
                          isAm: false,
                          childrenList: timeslotsPM,
                          isAmenitiesGrid: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: HeaderText(headerText: "AMENITIES"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SelectTimeGrid(
                          isAm: false,
                          childrenList: widget.venueAmenities,
                          isAmenitiesGrid: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: HeaderText(headerText: "LOCATION"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 70),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17.0),
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.center,
                                heightFactor: 0.6,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 400,
                                      child: StaticMap(
                                        zoom: 14,
                                        center: Location(
                                            widget.location.latitude,
                                            widget.location.longitude),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 400,
                                        scaleToDevicePixelRatio: false,
                                        googleApiKey:
                                            "AIzaSyCT5og_KFj-pDTt3_8uK98X5xDK7L7OIXk",
                                        markers: <Marker>[
                                          /// Define marker style
                                          Marker(
                                            //icon: "https://goo.gl/1oTJ9Y",
                                            color: Colors.green,
                                            label: "H",
                                            locations: [
                                              /// Provide locations for markers of a defined style
                                              Location(30.030986, 31.429570),
                                            ],
                                          ),

                                          /// Define another marker style with custom icon
                                        ],

                                        /// Declare optional markers
                                      ),
                                    ),
                                    Positioned(
                                        top: 90,
                                        right: 10,
                                        child: MapButton(
                                          miniView: true,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            bottomSheet: (Provider.of<BookingSelections>(context, listen: true)
                    .timeslotSelected())
                ? VenueBottomSheet(
                    venueName: widget.venueName,
                    venueArea: widget.venueArea,
                    venuePrice: widget.venuePrice,
                    bookings:
                        (Provider.of<BookingSelections>(context, listen: true)
                            .getBookings()),
                    daySelected: DateTime.now(),
                  )
                : Container(
                    height: 0,
                  ),
          ),
        );
      },
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key key,
    @required this.headerText,
  }) : super(key: key);

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: TextStyle(
        fontFamily: 'Chakra Petch',
        fontSize: 18,
        color: const Color(0xff2b8116),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }
}
