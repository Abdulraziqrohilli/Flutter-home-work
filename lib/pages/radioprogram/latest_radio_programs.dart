import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hurriyat/models/radioprograms/latest_radio-programm/Data.dart';
import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/pages/radioprogram/details.dart';
import 'package:hurriyat/pages/radioprogram/details1.dart';
import 'package:hurriyat/services/radioprogram/latestradioPrograms.dart';

class LatestRadioProgramsPage extends StatefulWidget {
  int languageid;
  LatestRadioProgramsPage({required this.languageid});

  @override
  State<LatestRadioProgramsPage> createState() => _AllNewsState();
}

class _AllNewsState extends State<LatestRadioProgramsPage> {
  List<Data> latestradioPrograms = [];
  bool _loading = true;
  // ignore: annotate_overrides
  void initState() {
    getlatestradioprogram();

    _onrefresh();
    super.initState();
  }

  Future<void> _onrefresh() async {
    // Future.delayed(Duration(seconds: 2), () {
    //   CircularProgressIndicator();
    // });
    // loading2 = false;
    Future.delayed(Duration(milliseconds: 100), () {
      _loading = false;
    });
  }

  getlatestradioprogram() async {
    LatestRadioProgram newsclass = LatestRadioProgram();
    await newsclass.getlatestradioprogram(widget.languageid);
    latestradioPrograms = newsclass.latestradioprograms;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Latest Radio Programs",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 130, 185),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:
          // RefreshIndicator(
          //   displacement: 250,
          //   backgroundColor: Colors.white,
          //   color: Colors.red,
          //   strokeWidth: 3,
          //   triggerMode: RefreshIndicatorTriggerMode.onEdge,
          //   onRefresh: () async {
          //     await Future.delayed(Duration(seconds: 3));
          //     setState(() {
          //       // getallpost();
          //       // CircularProgressIndicator();
          //       _loading ? Center(child: CircularProgressIndicator()) : initState();
          //       // Center(
          //       //   child: Text("Please Wait"),
          //       // );
          //       //  _onrefresh();
          //     });
          //   },
          //   child: _loading
          //       ? Center(child: CircularProgressIndicator())
          //       :
          SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: latestradioPrograms.length,
              itemBuilder: (context, index) {
                print("idont no");
                return RadioProgramSection(
                  url: latestradioPrograms[index].id as int,
                  Images: latestradioPrograms[index].image.toString(),
                  host: latestradioPrograms[index].host.toString(),
                  title: latestradioPrograms[index].title.toString(),
                  user: latestradioPrograms[index].user.toString(),
                  view: latestradioPrograms[index].views.toString(),
                );
              }),
        ),
      ),
    );
  }
}

class RadioProgramSection extends StatelessWidget {
  String Images, host, title, user;
  String view;
  int url;
  RadioProgramSection({
    required this.Images,
    required this.host,
    required this.title,
    required this.view,
    required this.user,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(blogUrl: url.toString())));
      },
      child: Container(
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: Images,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 88,
                  left: 155,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RadioDetails(
                                url: url.toString(),
                              )));
                    },
                    child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.play_arrow)),
                  ))
              // CircleAvatar(child: Image(image: AssetImage("assets/images/youtube11.jpg"))))
            ]),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              host,
              maxLines: 2,
              style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              user,
              style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              view,
              style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
