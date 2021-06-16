import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/image_builder.dart';
import 'package:instad_user/screens/venueProfilePage/venue_profile_page.dart';
import 'package:instad_user/services/firebasestorage.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/instad_user/lib/screens/venuesScreen/venueCard/venueImageCard/venue_image_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HorizontalCardView extends StatefulWidget {
  const HorizontalCardView(
      {Key key,
      @required this.listCards,
      @required this.isMapView,
      this.scrollTo,
      this.scrollController})
      : super(key: key);

  final List<ListCard> listCards;
  final bool isMapView;
  final ScrollController scrollController;
  final Function scrollTo;

  @override
  _HorizontalCardViewState createState() => _HorizontalCardViewState();
}

class _HorizontalCardViewState extends State<HorizontalCardView> {
  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireBaseStorageService.loadImage(context, imageName)
        .then((downloadUrl) {
      image = Image.network(
        downloadUrl.toString(),
        //fit: BoxFit.fill,
      );
    });

    return image;
  }

  @override
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);
  Widget build(BuildContext context) {
    setState(() {
      widget.scrollTo(scrollController);
    });

    return Container(
      //height: 112,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: widget.listCards.length,
        scrollDirection: Axis.horizontal,
        reverse: false,
        itemBuilder: (context, position) {
          var listCard = widget.listCards[position];
          return InkWell(
            onTap: () {
              print(listCard.venueId);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VenueProfilePage(
                    venueImage: ImageBuilder(listCard.venueId),
                    venueId: listCard.venueId,
                    venuePrice: listCard.venuePrice,
                    venueName: listCard.venueName,
                    venueArea: listCard.venueArea,
                    venueRating: listCard.venueRating,
                    venueDistance: listCard.venueDistance,
                    venueSports: listCard.venueSports,
                    location: listCard.location,
                    venueAmenities: listCard.venueAmenities,
                  ),
                ),
              );

              // Navigator.pushNamed(context, VenuePage.id);
            },
            child: Container(
              child: !widget.isMapView
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: VenueImageCard(
                        miniView: true,
                        venueImage: Align(
                          alignment: Alignment.center,
                          child: FutureBuilder(
                            future: _getImage(context,
                                "images/venueImages/${listCard.venueId}.png"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: const Color(0xffffffff),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xff707070)),
                                  ),
                                  child: snapshot.data,
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
// width: MediaQuery.of(context).size.width,
// height: 300,
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        venueArea: listCard.venueArea,
                        venueRating: listCard.venueRating,
                        venueDistance: listCard.venueDistance,
                        venueName: listCard.venueName,
                        venuePrice: listCard.venuePrice,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 240,
                              child: FutureBuilder(
                                future: _getImage(context,
                                    "images/venueImages/${listCard.venueId}.png"),
                                builder: (context, snapshot) {
                                  print(snapshot.data);
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: const Color(0xffffffff),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xff707070)),
                                      ),
                                      child: snapshot.data,
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
// width: MediaQuery.of(context).size.width,
// height: 300,

                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            Text(
                              listCard.venueName,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: const Color(0xff2e2e2e),
                                letterSpacing: 0.96,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              listCard.venueDistance.toString() + " KM",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: const Color(0x652e2e2e),
                                letterSpacing: 0.96,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(1, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
