import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/generalWidgets/string_to_icon_data.dart';
import 'package:instad_user/generalWidgets/wide_rounded_button.dart';
import 'package:instad_user/screens/filterModal/filterNamePanel/price_slider.dart';
import 'package:instad_user/screens/venueRequestPage/queryScreens/date_query.dart';
import 'package:instad_user/screens/venueRequestPage/queryScreens/time_query.dart';
import 'package:intl/intl.dart';
import 'queryScreens/areas_query.dart';
import 'queryScreens/sports_query.dart';
import 'package:instad_user/screens/venuesScreen/venues_screen.dart';
import 'package:provider/provider.dart';

class VenueRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {
                  Provider.of<VenueFilters>(context, listen: false).reset();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: const Color(0xffac4444),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Text(
              'Book a Venue',
              style: TextStyle(
                fontFamily: 'Chakra Petch',
                fontSize: 21,
                color: const Color(0xff2e2e2e),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: QueryBox(filter: "Sport"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: QueryBox(filter: "Date & Time"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: QueryBox(filter: "Area"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  "Maximum Price Per Hour",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: const Color(0x9a2e2e2e),
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  Provider.of<VenueFilters>(context)
                          .getMaxPrice("Selected")
                          .toString() +
                      " EGP",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: const Color(0xff2e2e2e),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: PriceSlider(),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Center(
                  child: WideRoundedButton(
                    isEnabled:
                        Provider.of<VenueFilters>(context).getSelectedSport() !=
                            null,
                    title: "FIND VENUES",
                    onPressed: () {
                      Provider.of<VenueFilters>(context, listen: false)
                          .applyFilters();
                      Navigator.pushNamed(context, VenuesScreen.id);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QueryBox extends StatelessWidget {
  const QueryBox({
    Key key,
    this.filter,
  }) : super(key: key);
  final String filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filter,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: const Color(0x9a2e2e2e),
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: filter != "Date & Time"
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                          width: 0.4, color: const Color(0xff2b8116)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 5),
                          child: InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: filter == "Sport"
                                          ? SportsQuery()
                                          : filter == "Area"
                                              ? AreasQuery()
                                              : Container()),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      StringToIconData(filter == "Sport"
                                          ? Provider.of<VenueFilters>(context,
                                                  listen: true)
                                              .getSelectedSport()
                                          : filter == "Area"
                                              ? "Location"
                                              : filter == "Date & Time"
                                                  ? Provider.of<VenueFilters>(
                                                          context,
                                                          listen: true)
                                                      .getDate("Unapplied")
                                                      .toString()
                                                  : "EMPTY"),
                                      color: Color(0xFFABCDA2),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        filter == "Sport"
                                            ? Provider.of<VenueFilters>(context,
                                                        listen: true)
                                                    .getSelectedSport()
                                                    .isNotEmpty
                                                ? Provider.of<VenueFilters>(
                                                        context,
                                                        listen: true)
                                                    .getSelectedSport()
                                                : "Pick a Sport"
                                            : filter == "Area"
                                                ? Provider.of<VenueFilters>(
                                                            context)
                                                        .getAreas("Selected")
                                                        .isNotEmpty
                                                    ? Provider.of<VenueFilters>(
                                                            context)
                                                        .getAreas("Selected")
                                                    : "Select Area".toString()
                                                : filter == "Date & Time"
                                                    ? Provider.of<VenueFilters>(
                                                            context,
                                                            listen: true)
                                                        .getDate("Selected")
                                                    : "EMPTY",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          color: const Color(0xff2e2e2e),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        filter == "Date & Time"
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 5),
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: filter == "Date & Time"
                                          ? InkResponse(
                                              onTap: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        TimeQuery());
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    StringToIconData("Time"),
                                                    color: Color(0xFFABCDA2),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "Select Time",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xff2e2e2e),
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                              width: 0.4, color: const Color(0xff2b8116)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 5),
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          StringToIconData("Date"),
                                          color: Color(0xFFABCDA2),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            DateFormat.MMMd()
                                                .format(
                                                    Provider.of<VenueFilters>(
                                                            context,
                                                            listen: true)
                                                        .getDate("Selected"))
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                              color: const Color(0xff2e2e2e),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) => DateQuery());
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                              width: 0.4, color: const Color(0xff2b8116)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 5),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: filter == "Date & Time"
                                  ? InkResponse(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (context) => TimeQuery());
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            StringToIconData("Time"),
                                            color: Color(0xFFABCDA2),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "Select Time",
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 16,
                                                color: const Color(0xff2e2e2e),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
