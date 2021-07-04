import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/screens/bookedPage/booked_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:instad_user/data/booking_selections.dart';

class SliderWidget extends StatefulWidget {
  SliderWidget({this.venueId});
  final String venueId;
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  var _maxWidth = 0.0;
  var _width = 0.0;
  var value = 0.0;
  bool booked = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      _maxWidth = constraint.maxWidth;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              begin: Alignment(-1.0, -1.0),
              end: Alignment(1.0, 1.0),
              colors: !booked
                  ? [
                      const Color(0xffe6e6e6),
                      const Color(0xfffafafa),
                      const Color(0xffe6e6e6)
                    ]
                  : [const Color(0xff2ca387), const Color(0xff2b8116)],
              stops: !booked ? [0.0, 0.502, 1.0] : [0.0, 1.0],
            ),
          ),
          height: 60,
          child: Stack(
            children: [
              Center(
                child: Shimmer(
                  gradient: LinearGradient(
                      colors: !booked
                          ? [
                              const Color(0xff2ca387),
                              const Color(0xff2b8116),
                            ]
                          : [Colors.white, Colors.white],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  child: Text(
                    (!booked ? "SLIDE TO BOOK" : "BOOKED"),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      //color: const Color(0xffffffff),
                      //letterSpacing: 2.24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: _width <= 55 ? 55 : _width,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: _onDrag,
                      onVerticalDragEnd: _onDragEnd,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        height: 55,
                        width: 55,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            gradient: LinearGradient(
                              begin: Alignment(1.0, 1.0),
                              end: Alignment(-1.0, -1.0),
                              colors: !booked
                                  ? [
                                      const Color(0xff2b8116),
                                      const Color(0xff2ca387),
                                    ]
                                  : [
                                      const Color(0xff2b8116),
                                    ],
                              stops: !booked ? [0.0, 1.0] : [1.0],
                            ),
                            boxShadow: !booked
                                ? [
                                    BoxShadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(1, 3),
                                      blurRadius: 6,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            !booked ? Icons.keyboard_arrow_right : Icons.check,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void _onDrag(DragUpdateDetails details) {
    setState(() {
      value = (details.globalPosition.dx) / _maxWidth;
      _width = _maxWidth * value;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    print("Drag end");
    if (value > 0.9) {
      print("Booking..");
      value = 1;
      Provider.of<BookingSelections>(context, listen: false).bookVenue(
        widget.venueId,
      );
      setState(() {
        _width = _maxWidth * value;
        booked = value > 0.9;
      });
      Provider.of<BookingSelections>(context, listen: false).clearSelections();
      //sleep(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BookedPage(
            booking: Provider.of<BookingSelections>(context, listen: false)
                .getLatestBooking()),
      ));
    } else {
      value = 0;
    }
  }
}
