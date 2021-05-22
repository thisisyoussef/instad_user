import 'package:flutter/material.dart';
import 'package:instad_user/services/firebasestorage.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/instad_user/lib/screens/venuesScreen/venueCard/venueImageCard/venue_image_card.dart';

class HorizontalCardView extends StatelessWidget {
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

  const HorizontalCardView({
    Key key,
    @required this.listCards,
  }) : super(key: key);

  final List<ListCard> listCards;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: listCards.length,
        scrollDirection: Axis.horizontal,
        reverse: false,
        itemBuilder: (context, position) {
          var listCard = listCards[position];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: VenueImageCard(
              miniView: true,
              venueImage: Align(
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: _getImage(
                      context, "images/venueImages/${listCard.venueId}.png"),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff707070)),
                        ),
                        child: snapshot.data,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
          );
        },
      ),
    );
  }
}
