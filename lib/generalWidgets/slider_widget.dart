import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderWidget extends StatefulWidget {
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
              color: Color(0xFF50B184),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              border: Border.all(color: Color(0xFF50B184), width: 2)),
          height: 60,
          child: Stack(
            children: [
              Center(
                child: Shimmer(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.black],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      (!booked ? "Slide to Book" : "Booked"),
                      style: TextStyle(fontSize: 30),
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
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Color(0xFF50B184),
                            //Color(0xFF50B184),
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
    if (value > 0.9) {
      value = 1;
    } else {
      value = 0;
    }
    setState(() {
      _width = _maxWidth * value;
      booked = value > 0.9;
    });
  }
}
