import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'slider_widget.dart';
import 'seperator.dart';
import 'package:instad_user/generalWidgets/string_to_icon_data.dart';

class VenueBottomSheet extends StatelessWidget {
  const VenueBottomSheet({
    Key key,
    this.venueName,
    this.venueArea,
    this.bookings,
    this.venuePrice,
    this.daySelected,
  }) : super(key: key);

  final String venueName;
  final String venueArea;
  final List bookings;
  final int venuePrice;
  final DateTime daySelected;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.25,
      maxChildSize: 0.6,
      initialChildSize: 0.25,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Icon(Icons.horizontal_rule),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 32.0),
                            child: Text(
                              'Total',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: const Color(0xff2e2e2e),
                                letterSpacing: 0.8,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            '400 EGP',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: const Color(0xff2b8116),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: const Color(0x6fffffff),
                          border: Border.all(
                            width: 1.0,
                            color: const Color(0xff2b8116),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                'Details',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  color: const Color(0xff2b8116),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: const Color(0xff2b8116),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SliderWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Seperator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: BookingDetailBox(
                      type: "Location",
                      title: venueName,
                      subtitle: venueArea,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: BookingDetailBox(
                      type: "Calendar",
                      title: DateFormat.MMMd().format(daySelected).toString(),
                      subtitle: bookings,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BookingDetailBox extends StatelessWidget {
  const BookingDetailBox({
    Key key,
    this.type,
    this.subtitle,
    this.title,
  }) : super(key: key);

  final String type;
  final String title;
  final dynamic subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          StringToIconData(type),
          size: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: const Color(0xff2e2e2e),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            subtitle is List && subtitle.length > 1
                ? Column(children: [
                    for (var text in subtitle)
                      Text(
                        text.toString() + " to ",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: const Color(0xff2e2e2e),
                          letterSpacing: 0.96,
                        ),
                        textAlign: TextAlign.left,
                      ),
                  ])
                : subtitle is List && subtitle.length == 1
                    ? Text(
                        (subtitle[0] > 12)
                            ? (subtitle[0] - 12).toString() + " PM"
                            : subtitle[0].toString() + " AM",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: const Color(0xff2e2e2e),
                          letterSpacing: 0.96,
                        ),
                        textAlign: TextAlign.left,
                      )
                    : Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: const Color(0xff2e2e2e),
                          letterSpacing: 0.96,
                        ),
                        textAlign: TextAlign.left,
                      ),
          ]),
        ),
      ],
    );
  }
}
