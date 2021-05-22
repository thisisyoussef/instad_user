import 'package:flutter/material.dart';

IconData SportAsIconData(String sport) {
  IconData icon;
  icon = sport == "Football"
      ? Icons.sports_soccer
      : sport == "Basketball"
          ? Icons.sports_basketball_outlined
          : sport == "Volleyball"
              ? Icons.sports_volleyball_outlined
              : sport == "Padel Tennis"
                  ? Icons.sports_tennis_outlined
                  : sport == "Tennis"
                      ? Icons.sports_baseball_outlined
                      : sport == "Handball"
                          ? Icons.sports_handball_outlined
                          : null;
  return icon;
}
