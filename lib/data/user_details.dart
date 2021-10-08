import 'package:firebase_auth/firebase_auth.dart';

UserDetails userInfo;
String loggedInUserID;
String userName = "";
String userNumber = "";
String userEmail;
PhoneAuthCredential otp;

class UserDetails {
  String loggedInUserID;
  String userName = "";
  String userNumber = "";
  String userEmail;
  UserDetails();

  void setUserID(_uid) {
    loggedInUserID = _uid;
  }

  String getUserID() {
    return loggedInUserID;
  }
}
