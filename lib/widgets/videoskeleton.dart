import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoSkeletonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        height: 200,
        // padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 10,
                    // ),

                    // SizedBox(
                    //   width: 5,
                    // // ),
                    // Expanded(
                    //   child: Column(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           "asdfasdfasdfasdfasdfsadf",
                    //           // maxLines: 2,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           "asdfasdfasdfasdfasdfsadf",
                    //           // maxLines: 2,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           "asdfasdfasdfasdfasdfsadf",
                    //           // maxLines: 2,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           "asdfasdfasdfasdfasdfsadf",
                    //           // maxLines: 2,
                    //         ),
                    //       ),
                    //       // Text(
                    //       //     "asdfasdfasdfasdfasdfsadf"),
                    //       // Text(
                    //       //     "asdfasdfasdfasdfasdfsadf"),
                    //       // Text(
                    //       //     "asdfasdfasdfasdfasdfsadf"),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/sport.jpg",
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ListTile(

          //   title: Text(
          //       'Item number $index as title'),
          //   subtitle: const Text('Subtitle here'),
          //   leading: const Icon(
          //     Icons.ac_unit,
          //     size: 88,
          //   ),
          // ),
        ),
      ),
    );
  }
}
