import 'package:flutter/material.dart';

///
///
///
@immutable
class ProfileHeroImage {
  ///
  ///
  ///
  static Future<void> show({
    @required BuildContext context,
    @required Object tag,
    @required ImageProvider<dynamic> image,
    double borderRadius = 16.0,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        fullscreenDialog: true,
        barrierColor: Colors.black45,
        pageBuilder: (context, first, secondaryAnimation) {
          return Center(
            child: Hero(
              tag: 'profilePhoto',
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Image(
                      width: MediaQuery.of(context).size.width -
                          (borderRadius * 2.0),
                      fit: BoxFit.cover,
                      image: image,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
