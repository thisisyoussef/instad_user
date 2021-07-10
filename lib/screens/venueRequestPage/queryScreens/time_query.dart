import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/generalWidgets/wide_rounded_button.dart';
import 'package:instad_user/screens/venueProfilePage/selectTimeGrid/select_time_grid.dart';
import 'package:instad_user/screens/venueRequestPage/queryScreens/time_slider.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/models/timeslot.dart';

class TimeQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Timeslot> timeslotsAM = List<Timeslot>.generate(
      12,
      (i) => Timeslot(
          time: Timestamp.fromDate(
            DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              DateTime(1, 1, 24).hour,
            ).add(
              Duration(hours: i),
            ),
          ),
          booked: false),
    );
    List<Timeslot> timeslotsPM = List<Timeslot>.generate(
      12,
      (i) => Timeslot(
          time: Timestamp.fromDate(
            DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              DateTime(1, 1, 12).hour,
            ).add(
              Duration(hours: i),
            ),
          ),
          booked: false),
    );
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
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: const Color(0xff2e2e2e),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TimeSlider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TimeSlider(),
                  ),
                ],
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
