import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:hurriyat/pages/Search.dart';
import 'dart:ui' as ui;

import 'package:hurriyat/pages/home.dart';

class Searchs extends StatefulWidget {
  int languageid;
  Searchs(this.languageid);
  @override
  State<Searchs> createState() => _SearchsState();
}

class _SearchsState extends State<Searchs> {
  TextEditingController controller = TextEditingController();
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: 360,
            height: 100,
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              keyboardType: TextInputType.streetAddress,
              onSubmitted: (value) {
                setState(() {
                  loading = false;
                });
              },
              onChanged: (value) {
                setState(() {
                  loading = false;
                });
              },
              controller: controller,
              textAlign:
                  widget.languageid == 1 ? TextAlign.left : TextAlign.right,
              textDirection: widget.languageid == 1
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: widget.languageid == 1 ? "Arial" : "Bahij",
              ),
              decoration: InputDecoration(
                  hintTextDirection: widget.languageid == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  hintStyle: TextStyle(height: 4),
                  // hintText:
                  hintText: "Search Here...".tr,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: widget.languageid == 1 ? "Arial" : "Bahij",
                  ),
                  prefixIcon: widget.languageid == 1
                      ? Icon(Icons.search)
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              loading = true;
                              controller.text.isEmpty
                                  ? Navigator.pop(context)
                                  : controller.clear();
                            });
                          },
                        ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  suffixIcon: widget.languageid == 1
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              loading = true;
                              controller.text.isEmpty
                                  ? Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ))
                                  : controller.clear();
                            });
                          },
                        )
                      : Icon(Icons.search)),
            ),
          ),
        ],
      ),
      body: loading == true || controller.text.isEmpty
          ? Container(
              child: Center(
                child: Text("No Search Until"),
              ),
            )
          : SearchNews(
              search: controller.text.toLowerCase(),
              languageid: widget.languageid),
    );
  }
}
