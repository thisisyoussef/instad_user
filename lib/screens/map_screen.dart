import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instad_user/directions_repository.dart';
import 'package:instad_user/screens/homeScreen/horizontal_card_view.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/functions/build_listCards.dart';
import 'package:instad_user/directions_model.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<ListCard> listCards = [];
  final _firestore = FirebaseFirestore.instance;
  GoogleMapController _controller;
  Directions _info;
  Location _locationTracker;
  Stream _locationSubscription;
  Circle circle;
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);
  Set<Marker> _markers = HashSet<Marker>();
  static bool isSearching = false;
  static AnimationController iconController;
  void updateMarker(LocationData newLocalData) {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      circle = Circle(
          circleId: CircleId("yourloco"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.green,
          center: latLng,
          fillColor: Colors.greenAccent);
    });
  }

  void getCurrentLocation() async {
    //var location = await _locationTracker.getLocation();

/*
    updateMarker(location);
*/

    _locationSubscription =
        _locationTracker.onLocationChanged.listen((newLocalData) {
      if (_controller != null) {
        _controller.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100)
              : CameraUpdate.newCameraPosition(
                  new CameraPosition(
                      bearing: 192,
                      target:
                          LatLng(newLocalData.latitude, newLocalData.longitude),
                      tilt: 0,
                      zoom: 10.00),
                ),
        );
        // updateMarker(newLocalData);
      }
    }) as Stream;
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      //_locationSubscription.dr();
    }
    super.dispose();
  }

  Function scrollToCallback = (ScrollController _scrollController) {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  };
  @override
  Widget build(BuildContext context) {
    buildListCards(context, listCards);
    final currentPosition = Provider.of<Position>(context);
    GoogleMap buildGoogleMap(Position currentPosition) {
      return GoogleMap(
        polylines: {
          if (_info != null)
            Polyline(
                polylineId: PolylineId('overview_polyline'),
                color: Colors.green,
                width: 5,
                points: _info.polyLinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList())
        },
        markers: _markers,
        mapType: MapType.normal,
        trafficEnabled: false,
        initialCameraPosition: CameraPosition(
          zoom: 12,
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
        ),
        compassEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          getCurrentLocation();
          setState(() {
            _controller = controller;
          });
        },
        zoomGesturesEnabled: true,
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        circles: Set.of((circle != null) ? [circle] : []),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('locations').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        //List<Timestamp> timeSlots;
        final fields = snapshot.data.docs;
        //listCards.clear();
        print("cleared listcards");
        for (var field in fields) {
          double latitude;
          double longitude;
          latitude = (field.data()['location'].latitude);
          print("lat " + latitude.toString());
          longitude = (field.data()['location'].longitude);
          Directions directions;
          Function setDirections = () async {
            print("setting directions..");
            await Future.wait({
              DirectionsRepository()
                  .getDirections(
                      origin: LatLng(30, 30),
                      destination: LatLng(latitude, longitude))
                  .then((value) => directions = value),
            });
          };
          print("Info is: " + _info.toString());
          print("Directions have become: " + directions.toString());
          print("Info: " + _info.toString());
          print("Directions aree: " + directions.toString());
          final String Id = field.id;
          final place = field.data()['place'];

          latitude != null && longitude != null
              ? _markers.add(
                  Marker(
                    onTap: () {
                      setState(() {
                        setDirections();
                        print("Directions marker: " + directions.toString());
                        _info = directions;
                      });
                      print("tapped marker");
                      print("Infoz: " + _info.toString());
                      setState(() {
                        _info = _info;
                        print("Infow: " + _info.toString());

                        // print("Info: " + _info.toString());
                        //print("Directions are: " + directions.toString());
                        scrollToCallback =
                            (ScrollController _scrollController) {
                          _scrollController.animateTo(
                              250 * (fields.indexOf(field).toDouble() + 0),
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        };
                        print("helloooo");
                        print("Directions marker2: " + directions.toString());

                        //print(_info.toString());
                      });
                    },
                    infoWindow: InfoWindow(title: field.data()['name']),
                    markerId: MarkerId(Id),
                    position: LatLng(latitude, longitude),
                  ),
                )
              : null;
        }
        return Scaffold(
          body: (currentPosition != null)
              ? Container(
                  child: (SafeArea(
                      child: Container(
                  height: MediaQuery.of(context).size.height - 25,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        child: Scaffold(
                          body: Column(
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                          //  padding:
//                EdgeInsets.only(
//                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child:
                                              buildGoogleMap(currentPosition)),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          color: Colors.white.withOpacity(1),
                                          height: 250,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Nearby',
                                                  style: TextStyle(
                                                    fontFamily: 'Chakra Petch',
                                                    fontSize: 19,
                                                    color:
                                                        const Color(0xff2e2e2e),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Container(
                                                height: 200,
                                                child: HorizontalCardView(
                                                  listCards: listCards,
                                                  isMapView: true,
                                                  scrollTo: scrollToCallback,
                                                  scrollController:
                                                      scrollController,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
