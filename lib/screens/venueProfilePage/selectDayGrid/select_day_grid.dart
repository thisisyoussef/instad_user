import 'package:flutter/material.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SelectDayGrid extends StatelessWidget {
  SelectDayGrid({
    Key key,
    @required this.selectedDay,
    this.isFilterVersion,
  }) : super(key: key);

  final DateTime selectedDay;
  final bool isFilterVersion;
  final items = List<DateTime>.generate(
    7,
    (i) => DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(
      Duration(days: i),
    ),
  );

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0.0);
    return Container(
      child: ListView.builder(
        controller: scrollController,
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        reverse: false,
        itemBuilder: (context, day) {
          return InkResponse(
            splashColor: Colors.transparent,
            onTap: () {
              DateTime thisDay = items[day];
              Provider.of<BookingSelections>(context, listen: false)
                  .clearSelections();
              !isFilterVersion
                  ? Provider.of<BookingSelections>(context, listen: false)
                      .setSelectedDay(thisDay)
                  : Provider.of<VenueFilters>(context, listen: false)
                      .setDate("Unapplied", thisDay);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Column(
                children: [
                  Text(
                    DateFormat.EEEE()
                        .format(items[day])
                        .toString()
                        .substring(0, 3),
                    style: TextStyle(
                      fontFamily: 'Hussar',
                      fontSize: 16,
                      color: Colors.black,
                      letterSpacing: 0.96,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: selectedDay.day == items[day].day
                          ? BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(1.0,
                                      1.0), // shadow direction: bottom right
                                )
                              ],
                              shape: BoxShape.circle,
                              color: const Color(0xff2b8116),
                            )
                          : null,
                      child: Center(
                        child: Text(
                          items[day].day.toString(),
                          style: TextStyle(
                            fontFamily: 'Hussar',
                            fontSize: 18,
                            color: selectedDay.day == items[day].day
                                ? Colors.white
                                : Color(0x652e2e2e),
                            letterSpacing: 0.96,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
