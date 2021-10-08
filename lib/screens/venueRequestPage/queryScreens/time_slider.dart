import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/data/venue_filters.dart';

class TimeSlider extends StatefulWidget {
  const TimeSlider({
    Key key,
  }) : super(key: key);

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now();
    return RangeSlider(
        labels: RangeLabels(
          DateFormat.j().format(startTime),
          DateFormat.j().format(endTime),
        ),
        divisions: 24,
        min: 0,
        max: 23,
        values: RangeValues(
          startTime.hour.toDouble(),
          endTime.hour.toDouble(),
        ),
        onChanged: (sliderValue) {
          setState(() {
            startTime = DateTime(2021, 1, 1, sliderValue.start.toInt());
            endTime = DateTime(2021, 1, 1, sliderValue.end.toInt());
          });
          Provider.of<VenueFilters>(context, listen: false).setStartTime(
              "Unapplied", DateTime(2021, 1, 1, sliderValue.start.toInt()));

          Provider.of<VenueFilters>(context, listen: false).setEndTime(
              "Unapplied", DateTime(2021, 1, 1, sliderValue.end.toInt()));
        });
  }
}
