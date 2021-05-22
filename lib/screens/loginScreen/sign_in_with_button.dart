import 'package:flutter/material.dart';

class signInWithButton extends StatelessWidget {
  const signInWithButton({
    Key key,
    @required this.socialmediaIcon,
  }) : super(key: key);

  final Image socialmediaIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: socialmediaIcon,
        ),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xffffffff),
        ),
      ),
    );
  }
}
