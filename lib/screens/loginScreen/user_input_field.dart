import 'package:flutter/material.dart';

class UserInputField extends StatefulWidget {
  const UserInputField({
    Key key,
    @required this.isPassword,
    this.callback,
  }) : super(key: key);
  final bool isPassword;
  final Function callback;
  @override
  _UserInputFieldState createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 8, top: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.isPassword == true ? 'Password' : 'Email',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                color: const Color(0xffffffff),
                letterSpacing: 0.8,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          width: 327,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0x34ffffff),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            style: TextStyle(color: Color(0xFF50B184)),
            cursorColor: Color(0xFF50B184),
            textAlign: TextAlign.center,
            obscureText: widget.isPassword,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              widget.callback(value);
              widget.callback(value);
            },
          ),
        ),
        widget.isPassword == true
            ? Padding(
                padding: const EdgeInsets.only(right: 18, bottom: 8, top: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: const Color(0xff70ba5e),
                      letterSpacing: 0.96,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
