import 'package:flutter/material.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'sportsCardGrid/sports_card_grid.dart';
import 'horizontal_card_view.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/models/venue_list.dart';
import 'package:instad_user/functions/build_listCards.dart';

class HomePage extends StatelessWidget {
  List<ListCard> listCards = [];
  HomePage();

  @override
  Widget build(BuildContext context) {
    buildListCards(context, listCards);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 88.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageHeader(),
            Expanded(
              child: SportsCardGrid(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: CardViewHeader(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 4, left: 0),
              child: HorizontalCardView(listCards: listCards),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Row(
                children: [
                  Text(
                    'Book',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 34,
                      color: const Color(0xff2e2e2e),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    ' Venue',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 34,
                      color: const Color(0xff2b8116),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Icon(
                Icons.search,
                size: 36,
                color: Color(0xFF2E2E2E),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 20, bottom: 15),
          child: Text(
            'By Sport',
            style: TextStyle(
              fontFamily: 'Chakra Petch',
              fontSize: 17,
              color: const Color(0xff2e2e2e),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

class CardViewHeader extends StatelessWidget {
  const CardViewHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Nearby',
          style: TextStyle(
            fontFamily: 'Chakra Petch',
            fontSize: 18,
            color: const Color(0xff2e2e2e),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: const Color(0xff2b8116),
                    letterSpacing: 0.96,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff2b8116),
                size: 14,
              )
            ],
          ),
        ),
      ],
    );
  }
}
