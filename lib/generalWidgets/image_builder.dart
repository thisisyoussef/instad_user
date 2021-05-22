import 'package:flutter/material.dart';
import 'package:instad_user/services/firebasestorage.dart';
import 'size_provider_widget.dart';

class ImageBuilder extends StatelessWidget {
  final String venueId;
  double imageHeight;
  ImageBuilder(this.venueId);
  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireBaseStorageService.loadImage(context, imageName)
        .then((downloadUrl) {
      image = Image.network(
        downloadUrl.toString(),
        //fit: BoxFit.fill,
      );
    });

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return SizeProviderWidget(
      child: FutureBuilder(
        future: _getImage(context, "images/venueImages/${venueId}.png"),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              child: snapshot.data,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              // width: MediaQuery.of(context).size.width,
              // height: 300,
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
      onChildSize: (size) {
        imageHeight = size.height;
      },
    );
  }
}
