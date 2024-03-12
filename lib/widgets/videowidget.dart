import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BlogTileVideo extends StatelessWidget {
  String desc, title, imageUrl;

  String? url;
  int? languageID;
  BlogTileVideo({
    required this.desc,
    required this.imageUrl,
    required this.title,
    required this.url,
    this.languageID,
  });

  double setSize(BuildContext context, double size) {
    return MediaQuery.of(context).size.width / size;
  }

  @override
  Widget build(BuildContext context) {
    var isportrate = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      child: Container(
        padding: EdgeInsets.only(left: 5, bottom: 2, top: 5, right: 5),
        child: Material(
          elevation: 3.0,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            crossAxisAlignment: languageID == 1
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.center,
            mainAxisAlignment: isportrate
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: isportrate ? 3 : 5,
                child: Stack(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Skeletonizer(
                            // enabled: true,
                            child: Container(
                          width: double.infinity,
                          height: 200,
                          child: Image.asset(
                            "assets/logos/logo@2x.png",
                            fit: BoxFit.fill,
                          ),
                        )),
                        errorWidget: (context, url, error) {
                          debugPrint(error.toString());

                          return Container(
                            width: double.infinity,
                            height: 200,
                            child: Image.asset("assets/logos/logo@2x.png",
                                fit: BoxFit.cover),
                          );
                        },
                      )),
                  // Positioned(
                  //   top: 58,
                  //   left: 60,
                  //   child: Container(
                  //     color: Colors.black,
                  //     height: 10,
                  //     width: 10,
                  //   ),
                  // ),
                  Positioned(
                    top: isportrate ? 80 : 50,
                    left: isportrate ? 160 : 110,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 8,
                          left: 5,
                          child: Container(
                            color: Colors.black,
                            height: 15,
                            width: 20,
                          ),
                        ),
                        Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.red,
                          size: 33,
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}