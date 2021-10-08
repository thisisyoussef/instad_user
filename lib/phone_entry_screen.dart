import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/screens/phone_verification_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'data/user_details.dart';
import 'generalWidgets/wide_rounded_button.dart';

class PhoneEntryScreen extends StatefulWidget {
  const PhoneEntryScreen({Key key}) : super(key: key);

  @override
  _PhoneEntryScreenState createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  String errorMessage = "";
  String _phoneNumber = "";
  String _phoneNumberNoCode = "";
  bool tocAgree = false;

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
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //constraints: BoxConstraints.expand(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 17, right: 0),
                          child: Text(
                            "what's your phone number?",
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
                          height: 44,
                          margin: EdgeInsets.only(top: 5),
                          child: IntlPhoneField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              labelText: 'Mobile Number',
                              border: OutlineInputBorder(
                                gapPadding: 10,
                                borderSide: BorderSide(width: 2),
                              ),
                            ),
                            countryCodeTextColor: Colors.white,
                            dropdownDecoration: BoxDecoration(),
                            showDropdownIcon: true,
                            showCountryFlag: false,
                            autoValidate: true,
                            initialValue: _phoneNumberNoCode,
                            textAlign: TextAlign.center,
                            initialCountryCode: "EG",
                            onChanged: (phoneNumberInput) {
                              _phoneNumberNoCode = phoneNumberInput.number;
                              _phoneNumber = phoneNumberInput.completeNumber;
                              print(_phoneNumber);
                            },
                          ),
                        ),
                        Container(
                          height: 44,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "I agree to the Terms and Conditions.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 64,
                                height: 44,
                                child: Switch(
                                    value: tocAgree,
                                    onChanged: (toggle) {
                                      setState(() {
                                        tocAgree = toggle;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: WideRoundedButton(
                      isEnabled: true,
                      //color: Colors.redAccent,
                      onPressed: () async {
                        if (tocAgree && _phoneNumber.length > 10) {
                          setState(() {
                            errorMessage = "";
                          });
                          print("Sending code");
                          userNumber = _phoneNumber;
                          print(userNumber);
                          print(_phoneNumber);
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: _phoneNumber,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              print(credential.smsCode);
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              setState(() {
                                errorMessage = e.message;
                              });
                            },
                            codeSent: (String verificationId, int resendToken) {
                              print(resendToken.toString() + " sent");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PhoneVerificationScreen(
                                          phoneNumber: _phoneNumber,
                                          id: verificationId),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              print(verificationId);
                            },
                          );
                          print("Done");
                        } else {
                          print("cant continue");
                        }
                      },
                      title: "Continue",
                    ),
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
