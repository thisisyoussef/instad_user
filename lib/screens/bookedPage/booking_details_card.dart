import 'package:flutter/material.dart';
import 'package:instad_user/models/booking.dart';
import 'package:instad_user/screens/venueRequestPage/venue_request_page.dart';
import 'package:intl/intl.dart';
import 'heading_title.dart';
import 'package:instad_user/screens/instad_root.dart';

class BookingDetailsCard extends StatelessWidget {
  BookingDetailsCard({Key key, this.isListview, this.fontScale, this.booking})
      : super(key: key);

  final bool isListview;
  double fontScale;
  final Booking booking;
  @override
  Widget build(BuildContext context) {
    if (fontScale == null) {
      fontScale = 1.0;
    }
    return Container(
      child: Column(
        children: [
          !isListview
              ? Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Transform.scale(
                    scale: 1.5,
                    child: FloatingActionButton(
                      child: Icon(Icons.check),
                      backgroundColor: Color(0xFF2B8116),
                      heroTag: "null",
                    ),
                  ),
                )
              : Container(),
          !isListview
              ? Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Booking Successful',
                    style: TextStyle(
                      fontFamily: 'Hussar',
                      fontSize: 30 * fontScale,
                      color: const Color(0xff2b8116),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isListview
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: const Color(0xFF707070),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Text(
                              "Booked for " +
                                  DateFormat.MMMd().format(booking.startTime),
                              style: TextStyle(
                                fontFamily: 'Hussar',
                                fontSize: 16,
                                color: const Color(0xff2e2e2e),
                                letterSpacing: 0.96,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 8.0, left: isListview ? 10 : 0),
                    child: HeadingTitle(
                      heading: "Venue",
                      title: "Hayah International Academy",
                      fontScale: this.fontScale,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 8.0, left: isListview ? 10 : 0),
                    child: HeadingTitle(
                      heading: "Area",
                      title: "Tagamoa",
                      fontScale: this.fontScale,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            width: 2,
                            color: const Color(0xFF707070),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width / 9,
                                  top: 16,
                                  left: isListview ? 10 : 4,
                                  bottom: 16,
                                ),
                                child: HeadingTitle(
                                  heading: "Date",
                                  title: DateFormat.MMMd()
                                      .format(booking.startTime),
                                  fontScale: this.fontScale,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 1,
                                    color: const Color(0xFF707070),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 16, bottom: 16),
                              child: Container(
                                child: HeadingTitle(
                                  heading: "Time",
                                  title: DateFormat.jm()
                                          .format(booking.startTime) +
                                      " to " +
                                      DateFormat.jm().format(booking.endTime),
                                  fontScale: this.fontScale,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: isListview ? 10 : 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingTitle(
                          heading: "Total",
                          title: "400 EGP",
                          fontScale: this.fontScale,
                        ),
                        isListview
                            ? OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  side: BorderSide(
                                    width: 1.1,
                                    color: const Color(0xff2b8116),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    'Book again',
                                    style: TextStyle(
                                      fontFamily: 'Hussar',
                                      fontSize: 18,
                                      color: const Color(0xff2b8116),
                                      letterSpacing: 1.92,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                ],
              ),
              //height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: isListview
                    ? Border.all(width: 1.0, color: const Color(0xff707070))
                    : null,
                color: const Color(0xfff4f6f8),
              ),
            ),
          ),
          !isListview
              ? TextButton(
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(VenueRequestPage.id));
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontFamily: 'Hussar',
                      fontSize: 20 * fontScale,
                      color: const Color(0xff2b8116),
                      letterSpacing: 2.24,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              : Container() //HeadingTitle(heading: "Total", title: "400 EGP"),
        ],
      ),
      height: !isListview ? MediaQuery.of(context).size.height / 1.45 : null,
      width: MediaQuery.of(context).size.width,
      decoration: !isListview
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            )
          : null,
    );
  }
}
