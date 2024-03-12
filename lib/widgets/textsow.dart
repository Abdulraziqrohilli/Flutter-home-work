// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

// class ShowText extends StatelessWidget {
//   String? textdata;
//   int? languageId;
//   double? textsize;
//   FontWeight? fontWeight;
//   int? maxline;
//   ShowText(
//       {
//         required this.textdata,
//       required this.languageId,
//       this.textsize,
//       this.fontWeight,
//       this.maxline
//       ,
//       }
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       maxLines: maxline,
//       textAlign:
//           languageId.toString() == '1' ? TextAlign.left : TextAlign.right,
//       textDirection: languageId.toString() == '1'
//           ? ui.TextDirection.ltr
//           : ui.TextDirection.rtl,
//       textdata.toString(),
//       style: TextStyle(
//         fontWeight: fontWeight,
//         fontSize: textsize,
//         fontFamily: languageId.toString() == '1' ? "Arial" : "Bahij",
//       ),
//     );
//   }
// }
