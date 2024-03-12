// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:hurriyat/pages/category_news.dart';

class CategoryTile extends StatefulWidget {
  String? categoryName;
  int languageId;
  int? fontsize;
  CategoryTile({
    this.categoryName,
    // this.image,
    this.fontsize,
    required this.languageId,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryPage(
                      name: widget.categoryName.toString(),
                      languageid: widget.languageId,
                    )));
      },
      child: Container(
        // width: 110,
        margin: widget.languageId == 1
            ? EdgeInsets.only(left: 5)
            : EdgeInsets.only(right: 5),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: const Color.fromARGB(255, 0, 130, 185)
            //  color: Color.fromARGB(255, 0, 130, 185),

            // providers.isDarkModes
            //     ? providers.lightdarkcolor = Colors.white
            //     : providers.lightdarkcolor = Colors.black
            ),
        child: Center(
            child: Text(
          widget.categoryName.toString().tr ?? 'null',
          textAlign:
              //  TextAlign.center,
              widget.languageId == 1 ? TextAlign.left : TextAlign.right,
          textDirection: widget.languageId == 1
              ? ui.TextDirection.ltr
              : ui.TextDirection.rtl,
          style: TextStyle(
              color: Colors.white,
              // providers.isDarkModes
              //     ? providers.lightdarkcolor = Colors.white
              //     : providers.lightdarkcolor = Colors.black,
              fontFamily: widget.languageId == 1
                  ? "Arial"
                  : widget.languageId == 4
                      ? "Al-Emarah"
                      : "Bahij",
              fontSize: widget.languageId == 1 ? 15 : 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        )),
      ),
    );
  }
}
