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
  final List<ListCard> listCards;

  const MapScreen({Key key, this.listCards}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin<MapScreen> {
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

  Function scrollToCallback = (ScrollController _scrollController) {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  };

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
  void initState() {
    print("initiating map screen state, listcards length: " +
        widget.listCards.length.toString());

    // TODO: implement initState

    for (ListCard listcard in widget.listCards) {
      print(listcard.location.latitude.toString() +
          listcard.location.longitude.toString());
      setState(() {
        _markers.add(
          Marker(
            onTap: () {
              setState(() {
                scrollToCallback = (ScrollController _scrollController) {
                  print(widget.listCards.indexOf(listcard));
                  print("scroll callback");
                  _scrollController.animateTo(
                      250 * (widget.listCards.indexOf(listcard).toDouble() + 0),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInCirc);
                };
              });
              //print(_info.toString());
            },
            infoWindow: InfoWindow(title: listcard.venueName),
            markerId: MarkerId(listcard.venueId),
            position:
                LatLng(listcard.location.latitude, listcard.location.longitude),
          ),
        );
      });
      print("Generating Marker For " + listcard.venueName);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      //_locationSubscription.dr();
    }
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void updateKeepAlive() {
    // TODO: implement updateKeepAlive
    super.updateKeepAlive();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final currentPosition = Provider.of<Position>(context);
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
                                          child: GoogleMap(
                                        /*      polylines: {
                                          if (_info != null)
                                            Polyline(
                                                polylineId: PolylineId(
                                                    'overview_polyline'),
                                                color: Colors.green,
                                                width: 5,
                                                points: _info.polyLinePoints
                                                    .map((e) => LatLng(
                                                        e.latitude,
                                                        e.longitude))
                                                    .toList())
                                        },*/
                                        markers: _markers,
                                        mapType: MapType.normal,
                                        trafficEnabled: false,
                                        initialCameraPosition: CameraPosition(
                                          zoom: 12,
                                          target: LatLng(
                                              currentPosition.latitude,
                                              currentPosition.longitude),
                                        ),
                                        compassEnabled: false,
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: true,
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          getCurrentLocation();
                                          setState(() {
                                            _controller = controller;
                                          });
                                        },
                                        zoomGesturesEnabled: true,
                                        mapToolbarEnabled: false,
                                        zoomControlsEnabled: false,
                                        circles: Set.of(
                                            (circle != null) ? [circle] : []),
                                      )),
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
                                                    fontFamily: 'Hussar',
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
                                                  listCards: widget.listCards,
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
                ),
              )),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );

    GoogleMap buildGoogleMap(Position currentPosition) {
/*
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
*/
    }

/*
      return StreamBuilder<QuerySnapshot>(
        // ignore: missing_return
        builder: (context, snapshot) {
          //List<Timestamp> timeSlots;
          final fields = snapshot.data.docs;
          //listCards.clear();
          print("cleared listcards");
          for (var listcard in listCards) {
            double latitude;
            double longitude;
            latitude = listcard.location.latitude;
            longitude = listcard.location.longitude;
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
            final String Id = listcard.venueId;
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
                                250 *
                                    (listCards.indexOf(listcard).toDouble() +
                                        0),
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInCirc);
                          };
                          print("helloooo");
                          print("Directions marker2: " + directions.toString());

                          //print(_info.toString());
                        });
                      },
                      infoWindow: InfoWindow(title: listcard.venueName),
                      markerId: MarkerId(Id),
                      position: LatLng(latitude, longitude),
                    ),
                  )
                : null;
          }
        },
      );
*/
  }
}
