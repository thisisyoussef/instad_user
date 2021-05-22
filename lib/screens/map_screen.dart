import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _firestore = FirebaseFirestore.instance;
  GoogleMapController _controller;
  Location _locationTracker;
  Stream _locationSubscription;
  Circle circle;
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
    var location = await _locationTracker.getLocation();

/*
    updateMarker(location);
*/

    _locationSubscription =
        _locationTracker.onLocationChanged.listen((newLocalData) {
      if (_controller != null) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: 192,
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
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

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    GoogleMap buildGoogleMap(Position currentPosition) {
      return GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
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
          final String Id = field.id;
          final place = field.data()['place'];
          double latitude;
          double longitude;
          try {
            latitude = double.parse(field.data()['latitude']);
            longitude = double.parse(field.data()['longitude']);
          } catch (e) {
            latitude = (field.data()['latitude']);
            longitude = (field.data()['longitude']);
          }
          latitude != null && longitude != null
              ? _markers.add(
                  Marker(
                    infoWindow: InfoWindow(title: "Title"),
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
                                        child: buildGoogleMap(currentPosition),
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
