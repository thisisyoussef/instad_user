import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instad_user/generalWidgets/wide_rounded_button.dart';
import 'package:instad_user/screens/instad_root.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../data/user_details.dart';
import 'loginScreen/user_input_field.dart';

final _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  static String id = "register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

String apiKey = 'AIzaSyDX17qdVwFzMv1VGg6SezoVhnpQ2aL8zcw';

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  String errorMessage = " ";
  final _auth = FirebaseAuth.instance;
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _verifiedPassword = "";
  TextEditingController textEditingController;
  StreamController<ErrorAnimationType> errorController;
  TabController _tabController;
  var tabs = <Tab>[
    Tab(child: SizedBox()),
    Tab(child: SizedBox()),
  ];
  @override
  void initState() {
    textEditingController = TextEditingController();
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2e2e2e),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
            )),
      ),
      backgroundColor: const Color(0xff2e2e2e),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 17, right: 0),
                          child: Text(
                            "sign up with instad",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Hussar",
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 9, right: 0),
                          child: Text(
                            "tell us a few more things and you're ready!",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: const Color(0xFF2B8116),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 9, right: 0),
                          child: Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width),
                          child: UserInputField(
                            title: "First Name",
                            isPassword: false,
                            callback: (String input) {
                              setState(() {
                                _firstName = input;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 100),
                        Container(
                          width: (MediaQuery.of(context).size.width),
                          child: UserInputField(
                            title: "Last Name",
                            isPassword: false,
                            callback: (String input) {
                              setState(() {
                                _lastName = input;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 100,
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width),
                          child: UserInputField(
                            initialValue: _email,
                            title: "Email",
                            isPassword: false,
                            callback: (String input) {
                              setState(() {
                                _email = input;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 100,
                        ),
                        UserInputField(
                            maxLength: 15,
                            isPassword: true,
                            title: "Password",
                            initialValue: _password,
                            callback: (input) {
                              setState(() {
                                _password = input;
                              });
                            }),
                        UserInputField(
                          isPassword: true,
                          title: "Verify Password",
                          initialValue: _verifiedPassword,
                          callback: (input) {
                            setState(() {
                              _verifiedPassword = input;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  WideRoundedButton(
                    isEnabled: true,
                    //color: Colors.redAccent,
                    onPressed: () async {
                      try {
                        if (_firstName == "") {
                          setState(() {
                            errorMessage = "Please enter your first neme.";
                          });
                        } else if (_lastName == "") {
                          setState(() {
                            errorMessage = "Please enter your last neme.";
                          });
                        } else if (EmailValidator.validate(_email) == false) {
                          setState(() {
                            errorMessage = "Please enter a valid email.";
                          });
                        } else if (_password.length < 8) {
                          setState(() {
                            errorMessage =
                                "Please enter a password with at least 8 characters.";
                          });
                        } else if (_password != _verifiedPassword) {
                          setState(() {
                            errorMessage =
                                "Please make sure your passwords match.";
                          });
                        } else {
                          //_auth.signInWithCredential(otp);
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _email, password: _password);
                          if (newUser != null) {
                            _firestore
                                .collection('users')
                                .doc(newUser.user.uid)
                                .set(({
                                  'uid': newUser.user.uid,
                                  'email': _email,
                                  'First Name': _firstName,
                                  'Last Name': _lastName,
                                  'Number': userNumber,
                                }));
                            //   Navigator.pop(context);
                            loggedInUserID = newUser.user.uid;
                            userName = _firstName;
                            Navigator.pushNamed(context, InstadRoot.id);
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                        setState(() {
                          errorMessage = e.message;
                        });
                      }
                    },
                    title: "Sign Up",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
