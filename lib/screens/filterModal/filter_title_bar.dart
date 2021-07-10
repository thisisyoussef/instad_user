import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class FilterTitleBar extends StatelessWidget {
  const FilterTitleBar({
    Key key,
    @required this.title,
    this.hasReset,
    this.cancelCallBack,
    this.saveCallBack,
  }) : super(key: key);

  final String title;
  final bool hasReset;
  final Function cancelCallBack;
  final Function saveCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.7,
            color: const Color(0xFF707070),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 18,
                    ),
                    Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: const Color(0xff2e2e2e),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                onTap: cancelCallBack,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Chakra Petch',
                  fontSize: 21,
                  color: const Color(0xff2e2e2e),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                  child: Container(
                    child: hasReset == true
                        ? Text(
                            'Reset',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: const Color(0xffac4444),
                            ),
                            textAlign: TextAlign.right,
                          )
                        : Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: const Color(0xff2b8116),
                            ),
                            textAlign: TextAlign.right,
                          ),
                  ),
                  onTap: () {
                    print("Tapped");
                    saveCallBack();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
