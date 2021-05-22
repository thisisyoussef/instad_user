import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.87,
      child: Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 30,
        color: Color(0xFF2B8116),
      ),
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top:
              BorderSide(width: 2.5, color: Color(0xFF707070).withOpacity(0.6)),
        ),
      ),
    );
  }
}
