import 'package:flutter/material.dart';
import 'package:instad_user/data/booking_selections.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/generalWidgets/wide_rounded_button.dart';
import 'package:instad_user/screens/venueProfilePage/selectDayGrid/select_day_grid.dart';
import 'package:provider/provider.dart';

class DateQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Pick the day you'd like to play",
                  style: TextStyle(
                    fontFamily: 'Hussar',
                    fontSize: 20,
                    color: const Color(0xff2e2e2e),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Material(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 100,
                    child: SelectDayGrid(
                      isFilterVersion: true,
                      selectedDay:
                          Provider.of<VenueFilters>(context, listen: true)
                              .getDate("Unapplied"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 100,
                      child: WideRoundedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        isEnabled: true,
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        title: "Cancel",
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: WideRoundedButton(
                        onPressed: () {
                          Provider.of<VenueFilters>(context, listen: false)
                              .setDate(
                                  "Selected",
                                  Provider.of<VenueFilters>(context,
                                          listen: false)
                                      .getDate("Unapplied"));
                          Navigator.pop(context);
                        },
                        color: Color(0xFF2B8116),
                        isEnabled: true,
                        title: "Save",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
