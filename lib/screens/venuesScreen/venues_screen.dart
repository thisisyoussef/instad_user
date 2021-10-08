import 'package:flutter/material.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'package:instad_user/functions/build_listCards.dart';
import 'package:instad_user/screens/filterModal/filter_screen.dart';
import 'venueCard/list_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:instad_user/models/venue_list.dart';

class VenuesScreen extends StatefulWidget {
  static String id = "venues_screen";
  List<ListCard> listCards = [];
  VenuesScreen();
  @override
  _VenuesScreenState createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
  @override
  Widget build(BuildContext context) {
    buildListCards(context, widget.listCards);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFF4F6F8),
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0xFFFFFFFF),
                height: 88,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: Column(
                        children: [
                          Text(
                            Provider.of<VenueFilters>(context, listen: true)
                                    .getSport() +
                                " Venues",
                            style: TextStyle(
                              fontFamily: 'Hussar',
                              fontSize: 18,
                              color: const Color(0xcb2e2e2e),
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            DateFormat.MMMd().format(DateTime.now()).toString(),
                            style: TextStyle(
                              fontFamily: 'Hussar',
                              fontSize: 13,
                              color: const Color(0xff2e2e2e),
                              letterSpacing: 0.96,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: InkWell(
                          child: Icon(
                            Icons.filter_list,
                            size: 28,
                          ),
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: FilterScreen(),
                                ),
                              ),
                            );
                            initState();
                          }),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.listCards.length,
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  itemBuilder: (context, position) {
                    var listCard = widget.listCards[position];
                    print(listCard.venueArea +
                        " is " +
                        Provider.of<VenueFilters>(context, listen: true)
                            .getAreas("Applied")
                            .contains(listCard.venueArea)
                            .toString());
                    return (Provider.of<VenueFilters>(context, listen: true)
                                        .getSport() ==
                                    "" ||
                                (Provider.of<VenueFilters>(context, listen: true)
                                            .getSport() ==
                                        listCard.venueSports[0] ||
                                    Provider.of<VenueFilters>(context, listen: true)
                                            .getSport() ==
                                        listCard.venueSports[1])) &&
                            (Provider.of<VenueFilters>(context, listen: true)
                                        .getAreas("Applied")
                                        .isEmpty ==
                                    true ||
                                Provider.of<VenueFilters>(context, listen: true)
                                    .getAreas("Applied")
                                    .contains(listCard.venueArea)) &&
                            Provider.of<VenueFilters>(context, listen: true)
                                    .getMaxPrice("Selected") >
                                listCard.venuePrice
                        /*&&
                            Provider.of<VenueFilters>(context, listen: true)
                                    .getMaxPrice() >=
                                listCard.venuePrice &&
                            Provider.of<VenueFilters>(context, listen: true)
                                    .getRating() >=
                                listCard.venueRating*/
                        //TODO make the search through sports more dynamic and efficient
                        ? ListCard(
                            venueArea: listCard.venueArea,
                            venueRating: listCard.venueRating,
                            venueDistance: listCard.venueDistance,
                            venueName: listCard.venueName,
                            venueId: listCard.venueId,
                            approved: listCard.approved,
                            venueSports: listCard.venueSports,
                            venuePrice: listCard.venuePrice,
                            location: listCard.location,
                            venueAmenities: listCard.venueAmenities,
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
