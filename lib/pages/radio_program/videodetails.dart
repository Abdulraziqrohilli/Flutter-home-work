import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:hurriyat/models/Videos/Videos.dart';
import 'package:hurriyat/models/radioprograms/Radio_programs_details.dart';
import 'package:hurriyat/services/language_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'dart:ui' as ui;

import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RVideoDetails extends StatefulWidget {
  String? title;
  String? host;
  String? videoId;
  String? createdAt;
  String? user;
  String? content;
  int? views;
  int? languageId;
  RVideoDetails(
      {this.languageId,
      this.videoId,
      this.content,
      this.createdAt,
      this.title,
      this.user,
      this.host,
      this.views});

  @override
  State<RVideoDetails> createState() => _RadioDetailsState();
}

class _RadioDetailsState extends State<RVideoDetails> {
  final f = new DateFormat('yyyy-MM-dd hh:mm');

  // List<Data> details = [];
  bool _loading = true;
  // Future<RadioProgramsDetails> getdetails() async {
  //   // String url = " https://hurriyat.net/api/news-details/" + 100;

  //   final response = await http.get(Uri.parse(
  //       'https://hurriyat.net/api/radio-programs-details/${widget.url}'));
  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200) {
  //     return RadioProgramsDetails.fromJson(data);
  //     // newsDetails = data;
  //   } else {
  //     return RadioProgramsDetails.fromJson(data);
  //   }
  // }

  late YoutubePlayerController _controller;

  // void listener() {
  //   if (mounted && !_controller.value.isFullScreen) {
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    // getdetails();
    _loading = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId.toString(),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _controller.addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        // Handle video ended event
        print('Video Ended');
      } else if (_controller.value.playerState == PlayerState.playing) {
        // Handle video playing event
        print('Video Playing');
      } else if (_controller.value.playerState == PlayerState.paused) {
        // Handle video paused event
        print('Video Paused');
      }
      print('Video loopin');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  late String videoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _loading
          ? Skeletonizer(
              // enabled: true,
              child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              child: Wrap(
                children: [
                  Image.asset(
                    "assets/logos/logo@2x.png",
                    fit: BoxFit.fill,
                  ),
                  Text("asljkdfasdfjasldfjasdlfasdjfasdlflfjsdf"),
                  Text("asljkdfasdfjasldfjasdlfasdjfasdlflfjsdf"),
                  Text("asljkdfasdfjasldfjasdlfasdjfasdlflfjsdf"),
                  Text("asljkdfasdfjasldfjasdlfasdjfasdlflfjsdf"),
                ],
              ),
            ))
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller,
                          // YoutubePlayerController(
                          //   initialVideoId: videoId,
                          //   flags: YoutubePlayerFlags(
                          //     mute: false,
                          //     // loop: true,
                          //     loop: true,
                          //     // disableDragSeek: true,
                          //     // enableCaption: false,
                          //     autoPlay: true,
                          //     // controlsVisibleAtStart: true,
                          //     // hideControls: true,
                          //     // hideThumbnail: true,
                          //     // startAt: 1,

                          //     // isLive: true,
                          //     // showLiveFulls/creenButton: true,
                          //     // startAt: 4,
                          //   ),
                          // ),
                          // bottomActions: [],
                          // aspectRatio: 16 / 9,

                          showVideoProgressIndicator: true,
                          progressColors: ProgressBarColors(
                            playedColor: Colors.amber,
                            handleColor: Colors.amberAccent,
                          ),
                          onReady: () {
                            print("video isrea");
                          },

                          onEnded: (YoutubeMetaData metaData) {
                            // Handle video ended event
                            print('Video Ended');
                          },
                          // on: (YoutubePlayerError error) {
                          //   // Handle video error event
                          //   print('Error: ${error.errorCode}');
                          // },
                          liveUIColor: Colors.amber,
                        ),
                        builder: (context, player) => Container(
                              child: player,
                            )),
                    Card(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Row(
                              // crossAxisAlignment:
                              //     CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          f
                                              .format(DateTime.parse(widget
                                                  .createdAt
                                                  .toString()) as DateTime)
                                              .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13
                                              // color: Colors.white,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.history_toggle_off_rounded,
                                        size: 19,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      textAlign:
                                          widget.languageId.toString() == '1'
                                              ? TextAlign.left
                                              : TextAlign.right,
                                      textDirection:
                                          widget.languageId.toString() == '1'
                                              ? ui.TextDirection.ltr
                                              : ui.TextDirection.rtl,
                                      widget.views.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily:
                                            widget.languageId.toString() == '1'
                                                ? "Arial"
                                                : "Bahij",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 19,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      textAlign:
                                          widget.languageId.toString() == '1'
                                              ? TextAlign.left
                                              : TextAlign.right,
                                      textDirection:
                                          widget.languageId.toString() == '1'
                                              ? ui.TextDirection.ltr
                                              : ui.TextDirection.rtl,
                                      widget.host.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        fontFamily:
                                            widget.languageId.toString() == '1'
                                                ? "Arial"
                                                : "Bahij",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.record_voice_over_rounded,
                                      size: 19,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      textAlign:
                                          widget.languageId.toString() == '1'
                                              ? TextAlign.left
                                              : TextAlign.right,
                                      textDirection:
                                          widget.languageId.toString() == '1'
                                              ? ui.TextDirection.ltr
                                              : ui.TextDirection.rtl,
                                      widget.user.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        fontFamily:
                                            widget.languageId.toString() == '1'
                                                ? "Arial"
                                                : "Bahij",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.person_3_rounded,
                                      size: 19,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Html(
                              data: widget.content.toString(),
                              style: {
                                "body": Style(
                                  // alignment: Alignment.topLeft,
                                  fontSize: FontSize(15.0),
                                  // fontWeight: FontWeight.w300,
                                  textAlign: widget.languageId.toString() == '1'
                                      ? TextAlign.left
                                      : TextAlign.right,
                                  direction: widget.languageId.toString() == '1'
                                      ? ui.TextDirection.ltr
                                      : ui.TextDirection.rtl,
                                  fontFamily:
                                      widget.languageId.toString() == '1'
                                          ? "Arial"
                                          : "Bahij",
                                ),
                              },
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Icon(
                            //       Icons.history_toggle_off_rounded,
                            //       size: 19,
                            //     ),
                            //     SizedBox(
                            //       width: 3,
                            //     ),
                            //     Text(
                            //       f
                            //           .format(DateTime.parse(
                            //                   widget.createdAt.toString())
                            //               as DateTime)
                            //           .toString(),
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w300, fontSize: 13
                            //           // color: Colors.white,
                            //           ),
                            //     ),
                            //     SizedBox(
                            //       width: 3,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }

  // @override
  // void Dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }
}
