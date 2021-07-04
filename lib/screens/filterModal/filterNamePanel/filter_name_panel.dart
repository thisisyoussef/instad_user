import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/generalWidgets/string_to_icon_data.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/screens/filterModal/filterNamePanel/expanded_filter_name_panel.dart';

class FilterNamePanel extends StatelessWidget {
  const FilterNamePanel({
    Key key,
    @required this.filter,
    @required this.sport,
    this.callBack,
  }) : super(key: key);

  final String filter;
  final String sport;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    Widget tile = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: const Color(0xFF707070),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Icon(StringToIconData(filter == "Sport"
                      ? Provider.of<VenueFilters>(context).getSelectedSport()
                      : filter)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontFamily: 'Chakra Petch',
                        fontSize: 15,
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                child: Row(
                  children: [
                    Text(
                      filter == "Sport"
                          ? Provider.of<VenueFilters>(context)
                              .getSelectedSport()
                          : filter == "Location"
                              ? Provider.of<VenueFilters>(context)
                                  .getAreas("Selected")
                                  .toString()
                              : filter == "Time"
                                  ? "Add"
                                  : filter == "Price"
                                      ? Provider.of<VenueFilters>(context)
                                          .getMaxPrice("Selected")
                                          .toString()
                                      : filter == "Amenities"
                                          ? "Add"
                                          : filter == "Rating"
                                              ? "Add"
                                              : "null",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: filter == "Areas" &&
                                (Provider.of<VenueFilters>(context)
                                        .getAreas("Selected")
                                        .length >
                                    3)
                            ? 14
                            : 16,
                        color: const Color(0xff2b8116),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    (filter == "Sport" ||
                            filter == "Areas" ||
                            filter == "Amenities")
                        ? Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff2b8116),
                          )
                        : Container(),
                  ],
                ),
                onTap: callBack,
              ),
            )
          ],
        ),
      ),
    );
    double _currentSliderValue = 300;

    bool twoButton = true;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpandableNotifier(
        child: Expandable(
            collapsed: ExpandableButton(child: tile),
            expanded:
                (filter == "Price") ? ExpandedFilterTile(tile: tile) : tile),
      ),
    );
  }
}
