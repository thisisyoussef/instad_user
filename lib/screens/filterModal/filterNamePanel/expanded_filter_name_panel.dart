import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'price_slider.dart';

class ExpandedFilterTile extends StatelessWidget {
  const ExpandedFilterTile({
    Key key,
    @required this.tile,
  }) : super(key: key);

  final Widget tile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableButton(child: tile),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: PriceSlider(),
        )
      ],
    );
  }
}
