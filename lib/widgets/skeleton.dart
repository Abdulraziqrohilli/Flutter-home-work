import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        height: 165,
        padding: const EdgeInsets.all(2.0),
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
                    // ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "asdfasdfasdfasdfasdfsadf",
                                // maxLines: 2,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "asdfasdfasdfasdfasdfsadf",
                                // maxLines: 2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "asdfasdfasdfasdfasdfsadf",
                                // maxLines: 2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "asdfasdfasdfasdfasdfsadf",
                                // maxLines: 2,
                              ),
                            ),
                          ),
                          // Text(
                          //     "asdfasdfasdfasdfasdfsadf"),
                          // Text(
                          //     "asdfasdfasdfasdfasdfsadf"),
                          // Text(
                          //     "asdfasdfasdfasdfasdfsadf"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/images/sport.jpg",
                        fit: BoxFit.cover,
                        height: 140,
                        width: 140,
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
