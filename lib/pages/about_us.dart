import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class AboutUs extends StatelessWidget {
  int languageID;
  AboutUs({required this.languageID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us".tr,
          textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
          textDirection:
              languageID == 1 ? ui.TextDirection.ltr : ui.TextDirection.rtl,
          style: TextStyle(
            // height: 1.5,
            overflow: TextOverflow.ellipsis,

            // color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            fontFamily: languageID == 1
                ? "Arial"
                : languageID == 4
                    ? "Al-Emarah"
                    : "Bahij",
          ),
        ),
        // backgroundColor: Color.fromRGBO(7, 41, 77, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: languageID == 1
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  "About Hurriyet".tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    overflow: TextOverflow.ellipsis,

                    // color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                Text(
                  "At Hurriyet, we are dedicated to bringing you the latest, most accurate, and compelling news stories. We understand the power of information in shaping opinions, fostering informed discussions, and driving positive change in our communities. Our mission is to provide you with news that matters, with integrity, impartiality, and a commitment to the highest journalistic standards."
                      .tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Application Developer".tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    overflow: TextOverflow.ellipsis,

                    // color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                Text(
                  "Abdulraziq Rohilli"
                      .tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  "Email Address".tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    overflow: TextOverflow.ellipsis,

                    // color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                Text(
                  "abdulraziqrohilli@gmail.com"
                      .tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  "Phone Number".tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    overflow: TextOverflow.ellipsis,

                    // color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                Text(
                  "+93771269657"
                      .tr,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset("assets/logos/logo@2x.png",
                      fit: BoxFit.cover),
                ),

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     shape: const StadiumBorder(),
                //     primary: Isswitch ? Colors.purple : Colors.pink,
                //   ),
                //   onPressed: () {},
                //   child: Text("Test Button"),
                // ),
                // Switch(
                //     value: Isswitch,
                //     onChanged: (bool newbool) {
                //       setState(() {
                //         Isswitch = newbool;
                //       });
                //     }),
                SizedBox(
                  height: 10,
                ),
                // Image.asset("assets/image/gourp.jpg"),
                // SizedBox(height: 10),
                // Image.asset("assets/image/group2.jpg"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
