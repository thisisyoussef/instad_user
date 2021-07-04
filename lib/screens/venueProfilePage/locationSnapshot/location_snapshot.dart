import 'package:flutter/material.dart';
import 'package:instad_user/screens/venueProfilePage/venue_profile_page.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:instad_user/generalWidgets/tiles/map_button.dart';

class LocationSnapshot extends StatelessWidget {
  const LocationSnapshot({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final VenueProfilePage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17.0),
        child: ClipRect(
          child: Align(
            alignment: Alignment.center,
            heightFactor: 0.6,
            child: Stack(
              children: [
                Container(
                  height: 400,
                  child: StaticMap(
                    zoom: 14,
                    center: Location(
                        widget.location.latitude, widget.location.longitude),
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    scaleToDevicePixelRatio: false,
                    googleApiKey: "AIzaSyCT5og_KFj-pDTt3_8uK98X5xDK7L7OIXk",
                    markers: <Marker>[
                      /// Define marker style
                      Marker(
                        //icon: "https://goo.gl/1oTJ9Y",
                        color: Colors.green,
                        label: "H",
                        locations: [
                          /// Provide locations for markers of a defined style
                          Location(30.030986, 31.429570),
                        ],
                      ),

                      /// Define another marker style with custom icon
                    ],

                    /// Declare optional markers
                  ),
                ),
                Positioned(
                    top: 90,
                    right: 10,
                    child: MapButton(
                      miniView: true,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
