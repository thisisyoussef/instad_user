import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/tiles/map_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'pageContent/venue_page_header.dart';
import 'selectTimeGrid/select_time_grid.dart';
import 'package:instad_user/models/timeslot.dart';
import 'venueBottomSheet/venue_bottom_sheet.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'pageContent/venue_info.dart';
import 'pageContent/header_text.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/functions/merge_date_time.dart';
import 'selectDayGrid/select_day_grid.dart';
import 'locationSnapshot/location_snapshot.dart';

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
          Timestamp selectedBooking = mergeDayTime(
              timeslot,
              Provider.of<BookingSelections>(context, listen: false)
                  .getSelectedDay());
          bool _booked = false;
          if (bookedslots.contains(selectedBooking)) {
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
                  elevation: 30,
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
                          child: HeaderText(headerText: "SELECT DAY")),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.0),
                          color: const Color(0xffffffff),
                        ),
                        child: SelectDayGrid(
                          selectedDay: Provider.of<BookingSelections>(context,
                                  listen: true)
                              .getSelectedDay(),
                        ),
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
                          dayselected: Provider.of<BookingSelections>(context,
                                  listen: false)
                              .getSelectedDay(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SelectTimeGrid(
                          isAm: false,
                          childrenList: timeslotsPM,
                          isAmenitiesGrid: false,
                          dayselected: Provider.of<BookingSelections>(context,
                                  listen: false)
                              .getSelectedDay(),
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
                        padding: const EdgeInsets.only(top: 16.0, bottom: 0),
                        child: LocationSnapshot(widget: widget),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            bottomNavigationBar: (Provider.of<BookingSelections>(context,
                        listen: true)
                    .timeslotSelected())
                ? VenueBottomSheet(
                    venueName: widget.venueName,
                    venueArea: widget.venueArea,
                    venuePrice: widget.venuePrice,
                    venueId: widget.venueId,
                    bookings:
                        (Provider.of<BookingSelections>(context, listen: true)
                            .getBookings()),
                    daySelected:
                        Provider.of<BookingSelections>(context, listen: false)
                            .getSelectedDay(),
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
