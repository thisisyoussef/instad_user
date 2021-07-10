import 'package:flutter/material.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/generalWidgets//wide_rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/screens/filterModal/filterNamePanel/filter_name_panel.dart';
import 'package:instad_user/screens/filterModal/filter_title_bar.dart';
import 'package:instad_user/generalWidgets//size_provider_widget.dart';
import 'package:instad_user/data/instad_data.dart';
import 'package:instad_user/screens/filterModal/filter_tile.dart';

class FilterScreen extends StatefulWidget {
  static String id = "filter_screen";
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String filterSwitch = "Default";
  double screenHeight = 0;
  String title = "Title";
  String _area;
  DateTime _startDate;
  DateTime _endDate;
  String _sport;
  int _distanceFromUser;
  int _maxPrice;
  List<String> _amenities;
  double _rating;

  @override
  Widget build(BuildContext context) {
    bool isSports = (filterSwitch == "Sports");
    bool isAreas = (filterSwitch == "Areas");
    String selectedSport = _sport;
    Function _cancelCallBack = () {
      setState(() {
        filterSwitch = "Default";
      });
    };

    return Consumer<VenueFilters>(builder:
        (BuildContext context, VenueFilters venueFilters, Widget child) {
      Function sportCheckBoxCallBack(bool checkboxState, String filterName) {
        checkboxState == true
            ? venueFilters.setUnappliedSport(filterName)
            : venueFilters.setUnappliedSport("");
      }

      Function areaCheckBoxCallBack(bool checkboxState, String filterName) {
        checkboxState == true
            ? venueFilters.addToAreas("Unapplied", filterName)
            : venueFilters.removeFromAreas("Unapplied", filterName);
      }

      return Container(
        color: Color(0xFF000000).withOpacity(0.5),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Icon(Icons.horizontal_rule),
                filterSwitch == "Default"
                    ? SizeProviderWidget(
                        child: Column(
                          children: [
                            FilterNamePanel(
                              filter: "Sport",
                              sport: venueFilters.getSport(),
                              callBack: () {
                                setState(() {
                                  filterSwitch = "Sports";
                                });
                              },
                            ),
                            FilterNamePanel(
                              filter: "Areas",
                              sport: venueFilters.getArea(),
                              callBack: () {
                                setState(() {
                                  filterSwitch = "Areas";
                                });
                              },
                            ),
                            FilterNamePanel(
                                filter: "Time",
                                sport: venueFilters
                                    .getDate("Selected")
                                    .toString()),
                            FilterNamePanel(
                                filter: "Price",
                                sport: venueFilters
                                    .getMaxPrice("Selected")
                                    .toString()),
                            FilterNamePanel(
                                filter: "Amenities",
                                sport: venueFilters.getAmenities().toString()),
                            FilterNamePanel(
                                filter: "Rating",
                                sport: venueFilters.getRating().toString()),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                            ),
                            WideRoundedButton(
                              title: "Apply",
                              isEnabled: true,
                              onPressed: () {
                                venueFilters.applyFilters();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        onChildSize: (size) {
                          screenHeight = size.height;
                        },
                      )
                    : Container(
                        height: screenHeight,
                        color: Colors.white,
                        child: Column(
                          children: [
                            FilterTitleBar(
                              title: filterSwitch,
                              hasReset: false,
                              cancelCallBack: _cancelCallBack,
                              saveCallBack: () {
                                isSports
                                    ? venueFilters.setSelectedSport(
                                        venueFilters.getUnappliedSport())
                                    : isAreas
                                        ? venueFilters.updateAreas("Unapplied")
                                        : null;
                                setState(() {
                                  filterSwitch = "Default";
                                });
                              },
                            ),
                            (isSports || isAreas)
                                ? Expanded(
                                    child: Consumer<InstadData>(
                                      builder: (context, instadData, child) {
                                        return ListView.builder(
                                          itemBuilder: (context, index) {
                                            final filterName = isSports
                                                ? InstadData.sports[index]
                                                : InstadData.areas[index];
                                            return FilterTile(
                                                taskTitle: filterName,
                                                isChecked: filterSwitch ==
                                                        "Sports"
                                                    ? venueFilters
                                                            .getUnappliedSport() ==
                                                        filterName
                                                    : venueFilters.inAreas(
                                                            "Unapplied",
                                                            filterName) ==
                                                        true,
                                                checkboxCallback: isSports
                                                    ? (checkboxState) {
                                                        sportCheckBoxCallBack(
                                                            checkboxState,
                                                            filterName);
                                                      }
                                                    : (checkboxState) {
                                                        areaCheckBoxCallBack(
                                                            checkboxState,
                                                            filterName);
                                                      });
                                          },
                                          itemCount: isSports
                                              ? InstadData.sports.length
                                              : InstadData.areas.length,
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
              ],
            )),
      );
    });
  }
}

//        Provider.of<VenueFilters>(context, listen: false).setSport("Football");
