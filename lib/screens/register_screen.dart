import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instad_user/screens/homeScreen/home_page.dart';
import 'package:instad_user/screens/instad_root.dart';
import '../data/user_details.dart';

final _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  static String id = "register_screen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

String apiKey = 'AIzaSyDX17qdVwFzMv1VGg6SezoVhnpQ2aL8zcw';

class _RegisterScreenState extends State<RegisterScreen> {
  String errorMessage = " ";
  final _auth = FirebaseAuth.instance;
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF50B184), Colors.white70],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 25,
                        color: Colors.redAccent,
                        letterSpacing: 0.96,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          child: Material(
                            color: Color(0x00000000),
                            child: TextFormField(
                              initialValue: _firstName,
                              decoration:
                                  InputDecoration(labelText: "First Name"),
                              style: TextStyle(),
                              onChanged: (firstName) {
                                setState(() {
                                  _firstName = firstName;
                                });
                                //   RegistrationScreen.userDetails.firstName = firstName;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          child: Material(
                            color: Color(0x00000000),
                            child: TextFormField(
                              initialValue: _lastName,
                              decoration:
                                  InputDecoration(labelText: "Last Name"),
                              style: TextStyle(),
                              onChanged: (lastName) {
                                setState(() {
                                  _lastName = lastName;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: Material(
                            color: Color(0x00000000),
                            child: TextFormField(
                              initialValue: _email,
                              decoration:
                                  InputDecoration(labelText: "Email Address"),
                              style: TextStyle(),
                              onChanged: (email) {
                                setState(() {
                                  _email = email;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: Material(
                            color: Color(0x00000000),
                            child: TextFormField(
                              obscureText: true,
                              initialValue: _password,
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              style: TextStyle(),
                              onChanged: (password) {
                                setState(() {
                                  _password = password;
                                });
                                //   RegistrationScreen.userDetails.firstName = firstName;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 10,
                          child: Material(
                            color: Color(0x00000000),
                            child: TextFormField(
                              obscureText: true,
                              initialValue: _phoneNumber,
                              decoration:
                                  InputDecoration(labelText: "Phone Number"),
                              style: TextStyle(),
                              onChanged: (phoneNumber) {
                                setState(() {
                                  _phoneNumber = phoneNumber;
                                });
                                //   RegistrationScreen.userDetails.firstName = firstName;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width - 80,
              child: FloatingActionButton(
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
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
                            'venues': [],
                            'Number': _phoneNumber,
                          }));
                      //   Navigator.pop(context);
                      UserDetails().loggedInUserID = newUser.user.uid;
                      UserDetails().userName = _firstName;
                      Navigator.pushNamed(context, InstadRoot.id);
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e.message);
                    setState(() {
                      errorMessage = e.message;
                    });
                  }
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.done,
                  color: Color(0xFF50B184),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
