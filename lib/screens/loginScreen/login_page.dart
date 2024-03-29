import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instad_user/models/venue.dart';
import 'package:instad_user/phone_entry_screen.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../data/user_details.dart';
import '../instad_root.dart';
import '../register_screen.dart';
import 'user_input_field.dart';
import '../../generalWidgets//wide_rounded_button.dart';
import 'sign_in_with_button.dart';
import 'package:instad_user/models/venue_list.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String email;
  String password;
  String errorMessage = " ";
  Image googleIcon = Image.asset(
    'assets/images/googleIcon.png',
    height: 32,
    width: 32,
  );
  Image facebookIcon = Image.asset('assets/images/facebookIcon.png');

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height;
    double newheight = height - padding.top - padding.bottom;
    return SafeArea(
      child: ModalProgressHUD(
        color: Colors.green,
        progressIndicator: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        inAsyncCall: showSpinner,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xff2e2e2e),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.height,
                      child: Image.asset(
                        'assets/images/3x/White Soccer Transparent BG@3x.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: newheight * 0.001),
                    child: Visibility(
                      visible: errorMessage != " ",
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          fontFamily: 'Hussar',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                          letterSpacing: 0.96,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: newheight * 0.02),
                    child: UserInputField(
                      isPassword: false,
                      callback: (String data) {
                        email = data;
                      },
                    ),
                  ),
                  UserInputField(
                    isPassword: true,
                    callback: (String data) {
                      password = data;
                      print("Input: " + data);
                      print("Password: " + password);
                    },
                  ),
                  WideRoundedButton(
                    title: "LOG IN",
                    isEnabled: true,
                    onPressed: () async {
                      print("Logging in..");
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final loggedInUser =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        setState(() {
                          showSpinner = false;
                        });
                        if (loggedInUser != null) {
                          print("Authenticated");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => InstadRoot(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                        setState(() {
                          showSpinner = false;
                          errorMessage = e.message;
                        });
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: newheight * 0.031),
                    child: Text(
                      'Don’t have an account?',
                      style: TextStyle(
                        fontFamily: 'Hussar',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.96,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: newheight * 0.02),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PhoneEntryScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'sign up with ',
                            style: TextStyle(
                              fontFamily: 'Hussar',
                              fontSize: 18,
                              color: const Color(0xff2b8116),
                              letterSpacing: 1.68,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Image.asset(
                              'assets/images/3x/greenBallLogo.png',
                              scale: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*        Padding(
                    padding: EdgeInsets.only(top: newheight * 0.02),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        fontFamily: 'Hussar',
                        fontSize: 14,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.96,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: newheight * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        signInWithButton(socialmediaIcon: googleIcon),
                        signInWithButton(socialmediaIcon: facebookIcon),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
