import 'package:flutter/material.dart';
import 'package:instad_user/data/instad_data.dart';
import 'package:instad_user/models/venue_list.dart';
import 'package:instad_user/services/venue_details.dart';
import 'package:instad_user/data/venue_filters.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/instad_user/lib/screens/loginScreen/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instad_user/screens/venueProfilePage/venue_profile_page.dart';
import 'package:instad_user/screens/venuesScreen/venueCard/list_card.dart';
import 'package:instad_user/screens/venuesScreen/venues_screen.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/instad_user/lib/screens/filterModal/filter_screen.dart';
import 'package:instad_user/services/geolocator_screen.dart';
import 'package:provider/provider.dart';
import 'screens/instad_root.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'selected_location.dart';
import 'package:instad_user/data/booking_selections.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.clearPersistence();
  //FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final locatorService = GeoLocatorService();
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => locatorService.getLocation(),
        ),
        ChangeNotifierProvider(create: (context) => VenueFilters()),
        ChangeNotifierProvider(create: (context) => InstadData()),
        ChangeNotifierProvider(create: (context) => VenueDetails()),
        ChangeNotifierProvider(create: (context) => SelectedLocation()),
        ChangeNotifierProvider(create: (context) => VenueList()),
        ChangeNotifierProvider(create: (context) => BookingSelections()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.black),
          primarySwatch: Colors.green,
          sliderTheme: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            valueIndicatorColor: Color(0xFF2B8116),
            //slider modifications
            thumbColor: Colors.white,
            inactiveTrackColor: Color(0xFF2B8116),
            activeTrackColor: Color(0xFF2B8116),
            overlayColor: Color(0x992E2E2E),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
          ),
        ),
        //home: InstadRoot(),
        initialRoute: LoginPage.id,
        routes: {
          InstadRoot.id: (context) => InstadRoot(),
          LoginPage.id: (context) => LoginPage(),
          //FilterScreen.id: (context) => FilterScreen(),
          VenueProfilePage.id: (context) => VenueProfilePage(),
          //ListCard.id: (context) => ListCard(),
          //VenuesScreen.id: (context) => VenuesScreen(listCards)
        },
      ),
    );
  }
}
