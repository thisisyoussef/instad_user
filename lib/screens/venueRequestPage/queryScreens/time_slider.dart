import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/data/venue_filters.dart';

class TimeSlider extends StatelessWidget {
  const TimeSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
        labels: RangeLabels("A", "B"),
        divisions: 13,
        min: 1,
        max: 10,
        values: RangeValues(1, 10),
        onChanged: (sliderValue) {});
  }
}
