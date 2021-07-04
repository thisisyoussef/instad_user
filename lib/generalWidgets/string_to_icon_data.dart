import 'package:flutter/material.dart';

IconData StringToIconData(String input) {
  IconData icon;
  icon = input == "Football"
      ? Icons.sports_soccer
      : input == "Basketball"
          ? Icons.sports_basketball_outlined
          : input == "Volleyball"
              ? Icons.sports_volleyball_outlined
              : input == "Padel Tennis"
                  ? Icons.sports_tennis_outlined
                  : input == "Tennis" || input == "Ball"
                      ? Icons.sports_baseball_outlined
                      : input == "Handball"
                          ? Icons.sports_handball_outlined
                          : icon = input == "Bibs"
                              ? Icons.sports_mma_outlined
                              : input == "Bathroom"
                                  ? Icons.wc
                                  : input == "Drinks"
                                      ? Icons.local_drink_sharp
                                      : input == "Prayer Area"
                                          ? Icons
                                              .airline_seat_flat_angled_outlined
                                          : input == "Tennis"
                                              ? Icons.sports_baseball_outlined
                                              : input == "Handball"
                                                  ? Icons
                                                      .sports_handball_outlined
                                                  : input == "Location"
                                                      ? Icons
                                                          .location_on_outlined
                                                      : input == "Areas"
                                                          ? Icons
                                                              .location_on_outlined
                                                          : input == "Calendar"
                                                              ? Icons
                                                                  .calendar_today_rounded
                                                              : input == "Time"
                                                                  ? Icons
                                                                      .access_time_rounded
                                                                  : input ==
                                                                          "Date"
                                                                      ? Icons
                                                                          .calendar_today
                                                                      : input ==
                                                                              "Price"
                                                                          ? Icons
                                                                              .attach_money_outlined
                                                                          : input == "Amenities"
                                                                              ? Icons.wc_outlined
                                                                              : input == "Rating"
                                                                                  ? Icons.star_outline
                                                                                  : null;
  return icon;
}
