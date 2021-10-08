import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/data/venue_filters.dart';

class PriceSlider extends StatelessWidget {
  const PriceSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
        label: Provider.of<VenueFilters>(context)
            .getMaxPrice("Selected")
            .toString(),
        divisions: 13,
        min: 100,
        max: 750,
        value: Provider.of<VenueFilters>(context, listen: true)
                    .getMaxPrice("Selected") !=
                null
            ? Provider.of<VenueFilters>(context, listen: true)
                .getMaxPrice("Selected")
                .toDouble()
            : 100,
        onChanged: (sliderValue) {
          Provider.of<VenueFilters>(context, listen: false)
              .setMaxPrice("Selected", sliderValue.toInt());
        });
  }
}
