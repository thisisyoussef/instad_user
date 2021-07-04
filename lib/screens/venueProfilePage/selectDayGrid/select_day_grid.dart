import 'package:flutter/material.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SelectDayGrid extends StatelessWidget {
  const SelectDayGrid({
    Key key,
    @required this.selectedDay,
    @required this.items,
  }) : super(key: key);

  final DateTime selectedDay;
  final List<DateTime> items;
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0.0);
    return ListView.builder(
      controller: scrollController,
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      reverse: false,
      itemBuilder: (context, day) {
        return InkWell(
          onTap: () {
            DateTime thisDay = items[day];
            Provider.of<BookingSelections>(context, listen: false)
                .clearSelections();
            Provider.of<BookingSelections>(context, listen: false)
                .setSelectedDay(thisDay);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              children: [
                Text(
                  DateFormat.EEEE()
                      .format(items[day])
                      .toString()
                      .substring(0, 3),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
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
                    decoration: Provider.of<BookingSelections>(context,
                                    listen: false)
                                .getSelectedDay() ==
                            items[day]
                        ? BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 1.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    1.0, 1.0), // shadow direction: bottom right
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
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: Provider.of<BookingSelections>(context,
                                          listen: false)
                                      .getSelectedDay() ==
                                  items[day]
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
    );
  }
}
