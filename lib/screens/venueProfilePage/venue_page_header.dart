import 'package:flutter/material.dart';
import 'package:instad_user/generalWidgets/image_builder.dart';

class VenuePageHeader extends StatelessWidget {
  const VenuePageHeader({
    Key key,
    @required this.venueImage,
  }) : super(key: key);

  final ImageBuilder venueImage;

  Widget _buildImageSlider(BuildContext context, ImageBuilder venueImage) {
    var _pageController = PageController();
    // print(venueImage.imageHeight);
    return Container(
      //height: venueImage.imageHeight,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return venueImage;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 227, child: _buildImageSlider(context, venueImage)),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.8),
                Color(0xFF707070).withOpacity(0.6),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            height: 88,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}
