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
    this.venueId,
  }) : super(key: key);

  final String venueName;
  final String venueArea;
  final List bookings;
  final int venuePrice;
  final DateTime daySelected;
  final String venueId;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.21,
      maxChildSize: 0.45,
      initialChildSize: 0.21,
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
            child: Column(
              children: [
                Padding(
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
                                    fontFamily: 'Hussar',
                                    fontSize: 16,
                                    color: const Color(0xff2e2e2e),
                                    letterSpacing: 0.8,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Text(
                                (bookings.length * venuePrice).toString() +
                                    ' EGP',
                                style: TextStyle(
                                  fontFamily: 'Hussar',
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
                                      fontFamily: 'Hussar',
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
                        child: SliderWidget(
                          venueId: venueId,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 1),
                  child: Seperator(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
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
                          title:
                              DateFormat.MMMd().format(daySelected).toString(),
                          subtitle: bookings,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 1),
                  child: Seperator(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            venuePrice.toString(),
                            style: TextStyle(
                              fontFamily: 'Hussar',
                              fontSize: 20,
                              color: const Color(0xff2e2e2e),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'EGP/ Hour',
                              style: TextStyle(
                                fontFamily: 'Hussar',
                                fontSize: 17,
                                color: const Color(0xff2e2e2e),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontFamily: 'Hussar',
                                fontSize: 16,
                                color: const Color(0xff2e2e2e),
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                (bookings.length * venuePrice).toString(),
                                style: TextStyle(
                                  fontFamily: 'Hussar',
                                  fontSize: 23,
                                  color: const Color(0xff2b8116),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'EGP',
                                style: TextStyle(
                                  fontFamily: 'Hussar',
                                  fontSize: 16,
                                  color: const Color(0xff2e2e2e),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
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
          size: 36,
          color: Color(0xFF2E2E2E),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Hussar',
                fontSize: 20,
                color: const Color(0xff2e2e2e),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            subtitle is List && subtitle.length > 1
                ? Column(children: [
                    Text(
                      (subtitle[0] > 12 && subtitle[subtitle.length - 1] > 12)
                          ? (subtitle[0] - 12).toString() +
                              " to " +
                              (subtitle[subtitle.length - 1] - 11).toString() +
                              " PM"
                          : (subtitle[0] < 12 &&
                                  subtitle[subtitle.length - 1] < 12)
                              ? subtitle[0].toString() +
                                  " to " +
                                  (subtitle[subtitle.length - 1] + 1)
                                      .toString() +
                                  " AM"
                              : subtitle[0].toString() +
                                  " AM" +
                                  " to " +
                                  (subtitle[subtitle.length - 1] - 11)
                                      .toString() +
                                  " PM",
                      style: TextStyle(
                        fontFamily: 'Hussar',
                        fontSize: 18,
                        color: const Color(0xff2e2e2e),
                        letterSpacing: 0.96,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ])
                : subtitle is List && subtitle.length == 1
                    ? Text(
                        (subtitle[0] > 12)
                            ? (subtitle[0] - 12).toString() +
                                " to " +
                                (subtitle[0] - 11).toString() +
                                " PM"
                            : subtitle[0].toString() +
                                " to " +
                                (subtitle[0] + 1).toString() +
                                " AM",
                        style: TextStyle(
                          fontFamily: 'Hussar',
                          fontSize: 18,
                          color: const Color(0xff2e2e2e),
                          letterSpacing: 0.96,
                        ),
                        textAlign: TextAlign.left,
                      )
                    : Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Hussar',
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
