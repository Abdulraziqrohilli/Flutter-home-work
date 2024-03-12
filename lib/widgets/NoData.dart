import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataAvailableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.content_paste_search_sharp),
              Center(
                child: Text(
                    "     No Data Availabe! \n Please Try Again Later.".tr),
              ),
            ],
          ),
        ));
  }
}
