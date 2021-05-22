import 'package:instad_user/screens/venueProfilePage/venue_profile_page.dart';
import 'package:instad_user/services/venue_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'map_button.dart';
import 'venueImageCard/venue_image_card.dart';
import 'dropdown_button.dart';
import 'package:instad_user/generalWidgets/image_builder.dart';
import 'package:instad_user/generalWidgets/tiles/sports_tile_row.dart';

class ListCard extends StatefulWidget {
  static String id = "list_card";
  ListCard({
    this.venueId,
    this.approved,
    this.venueName,
    this.venueArea,
    this.venueRating,
    this.venueDistance,
    this.venueSports,
    this.venuePrice,
  });
  final String venueName;
  final String venueArea;
  final double venueRating;
  final int venueDistance;
  final bool approved;
  final String venueId;
  final List venueSports;
  final int venuePrice;
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  String easeOfAccess;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget venueImage = ImageBuilder(widget.venueId);
    print(MediaQuery.of(context).size.height * 0.36);
    print(MediaQuery.of(context).size.width * 0.87);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: InkWell(
        onTap: () {
          print(widget.venueId);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VenueProfilePage(
                    venueImage: venueImage,
                  )));

          // Navigator.pushNamed(context, VenuePage.id);
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.36,
            width: MediaQuery.of(context).size.width * 0.87,
            child: Column(
              children: [
                Container(
                  //width: 303,
                  height: 184,
                  child: VenueImageCard(
                    miniView: false,
                    venueImage: Align(
                      alignment: Alignment.center,
                      child: Hero(
                        child: venueImage,
                        tag: "venue image",
                      ),
                    ),
                    venueName: widget.venueName,
                    venueArea: widget.venueArea,
                    venueDistance: widget.venueDistance,
                    venueRating: widget.venueRating,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SportsTileRow(venueSports: widget.venueSports),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: MapButton(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DropDownButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
