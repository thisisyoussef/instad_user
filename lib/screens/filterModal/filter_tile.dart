import 'package:flutter/material.dart';

class FilterTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function removeTaskCallback;

  FilterTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallback,
      this.removeTaskCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 34),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: const Color(0xFF707070),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taskTitle,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: const Color(0xff2e2e2e),
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: 20,
                    //changed width from 14 to 25, changed rounded edges radius
                    child: Checkbox(
                      autofocus: true,
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      activeColor: Color(0xFF2B8116),
                      value: isChecked,
                      checkColor: Colors.white,
                      onChanged: checkboxCallback,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );

    return ListTile(
        onLongPress: removeTaskCallback,
        title: Text(
          taskTitle,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            color: const Color(0xff2e2e2e),
          ),
          textAlign: TextAlign.left,
        ),
        trailing: Checkbox(
          autofocus: true,
          focusColor: Colors.black,
          hoverColor: Colors.black,
          activeColor: Color(0xFF2B8116),
          value: isChecked,
          checkColor: Colors.white,
          onChanged: checkboxCallback,
        ));
  }
}
