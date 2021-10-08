import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/generalWidgets/string_to_icon_data.dart';
import 'package:instad_user/generalWidgets/wide_rounded_button.dart';
import 'package:instad_user/screens/filterModal/filterNamePanel/price_slider.dart';
import 'package:instad_user/screens/instad_root.dart';
import 'package:instad_user/screens/venuesScreen/venues_screen.dart';
import 'package:provider/provider.dart';
import 'query_box.dart';

class VenueRequestPage extends StatelessWidget {
  static String id = "venue_request_page_screen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {
                  Provider.of<VenueFilters>(context, listen: false).reset();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontFamily: 'Hussar',
                    fontSize: 18,
                    color: const Color(0xffac4444),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Text(
              'Book a Venue',
              style: TextStyle(
                fontFamily: 'Hussar',
                fontSize: 21,
                color: const Color(0xff2e2e2e),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: QueryBox(filter: "Sport"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: QueryBox(filter: "Date & Time"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: QueryBox(filter: "Area"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      "Maximum Price Per Hour",
                      style: TextStyle(
                        fontFamily: 'Hussar',
                        fontSize: 16,
                        color: const Color(0x9a2e2e2e),
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      Provider.of<VenueFilters>(context)
                              .getMaxPrice("Selected")
                              .toString() +
                          " EGP",
                      style: TextStyle(
                        fontFamily: 'Hussar',
                        fontSize: 18,
                        color: const Color(0xff2e2e2e),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: PriceSlider(),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Center(
                      child: WideRoundedButton(
                        isEnabled: Provider.of<VenueFilters>(context)
                                .getSelectedSport() !=
                            null,
                        title: "FIND VENUES",
                        onPressed: () {
                          Provider.of<VenueFilters>(context, listen: false)
                              .applyFilters();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      VenuesScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
