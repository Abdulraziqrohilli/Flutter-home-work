import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hurriyat/utils/constants/config.dart';

class NetworkImageWidget extends StatelessWidget {
  String imageurl;
  double? height, width;
  NetworkImageWidget({required this.imageurl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageurl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: Config.screenHeight = height,
      placeholder: (context, url) => Center(
        child: Container(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) {
        debugPrint(error.toString());
        // debugPrint(
        //     error.toString());
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/images/general.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: Config.screenHeight = 230,
              ),
            ],
          ),
        );
      },
    );
  }
}
