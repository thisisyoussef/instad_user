import 'package:flutter/material.dart';
import 'package:instad_user/data/instad_data.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/screens/filterModal/filter_tile.dart';
import 'package:instad_user/screens/filterModal/filter_title_bar.dart';
import 'package:provider/provider.dart';

class AreasQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function areaCheckBoxCallBack(bool checkboxState, String filterName) {
      checkboxState == true
          ? Provider.of<VenueFilters>(context, listen: false)
              .addToAreas("Unapplied", filterName)
          : Provider.of<VenueFilters>(context, listen: false)
              .removeFromAreas("Unapplied", filterName);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterTitleBar(
              saveCallBack: () {
                Provider.of<VenueFilters>(context, listen: false)
                    .updateAreas("Unapplied");
                Navigator.pop(context);
              },
              title: "Areas",
              hasReset: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 24, bottom: 8),
              child: Text(
                "Select areas you'd like to play in",
                style: TextStyle(
                  fontFamily: 'Hussar',
                  fontSize: 14,
                  color: const Color(0xff2e2e2e),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    String filterName = InstadData.areas[index];
                    return FilterTile(
                        taskTitle: filterName,
                        isChecked:
                            Provider.of<VenueFilters>(context, listen: true)
                                    .inAreas("Unapplied", filterName) ==
                                true,
                        checkboxCallback: (checkboxState) {
                          areaCheckBoxCallBack(checkboxState, filterName);
                        });
                  },
                  itemCount: InstadData.areas.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
