import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instad_user/data/user_details.dart';
import 'package:instad_user/screens/register_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key key, this.phoneNumber, this.id})
      : super(key: key);
  final String phoneNumber;
  final String id;
  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  String errorMessage = "";
  TextEditingController textEditingController;
  FirebaseAuth auth = FirebaseAuth.instance;
  String code = "";
  @override
  void initState() {
    textEditingController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2e2e2e),
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 0, top: 22, right: 0),
              child: Text(
                "verify your phone number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 63, top: 9, right: 63),
              child: Text(
                "please enter the 6 digit code sent to " + widget.phoneNumber,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(top: 9),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: PinCodeTextField(
                backgroundColor: const Color(0xff2e2e2e),
                appContext: context,
                pastedTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                obscuringWidget:
                    Image.asset("assets/images/3x/instad white circle@3x.png"),
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                validator: (v) {
                  if (v.length < 3) {
                    return null;
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  activeColor: Color(0xFF2B8116),
                  inactiveFillColor: const Color(0xff2e2e2e),
                  selectedFillColor: const Color(0xff2e2e2e),
                  errorBorderColor: Colors.white,
                  selectedColor: Color(0xFF2B8116),
                  disabledColor: Colors.white,
                  inactiveColor: Colors.white,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 30,
                  activeFillColor: Color(0xFF2B8116),
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.id, smsCode: code);
                  await auth.signInWithCredential(credential);
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                onChanged: (v) {
                  print(v);
                  setState(() {
                    code = v;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
//if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
