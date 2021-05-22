import 'package:flutter/material.dart';
import 'sport_icon.dart';

class SportsTileRow extends StatelessWidget {
  const SportsTileRow({
    Key key,
    @required this.venueSports,
  }) : super(key: key);

  final List venueSports;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              for (var sport in venueSports)
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: SportIcon(sport),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
