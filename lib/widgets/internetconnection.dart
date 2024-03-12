import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class MyAppInternet extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppInternet> {
  late Connectivity _connectivity;
  late ConnectivityResult _connectivityResult;
  bool isshow = true;
  void setDelayedMessage() {
    // Delay the execution by 3 seconds
    Future.delayed(Duration(seconds: 5), () {
      // Set the message after the delay
      setState(() {
        _showMessage();

        isshow = false;
      });
    });
  }

  @override
  void initState() {
    setDelayedMessage();

    super.initState();

    // Initialize Connectivity
    _connectivity = Connectivity();
    // Subscribe to connection changes
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
      // Show overlay notification when connectivity changes
      showConnectivityOverlay(result);
    });
    // Get initial connection status
    _initConnectivity();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectivityResult = result;
    });
  }

  void _showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor:
              //  Colors.red,
              _connectivityResult == ConnectivityResult.none
                  ? Colors.red
                  : Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(
              milliseconds:
                  _connectivityResult == ConnectivityResult.none ? 6000 : 2000),
          content: Row(
            children: [
              _connectivityResult == ConnectivityResult.none
                  ? Text("No Internet Connection".tr,
                      maxLines: 1,
                      style: TextStyle(
                        // height: 1.5,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        fontFamily: "Bahij",
                      ))
                  // : Text(""),
                  : Text("Internet Connection Available".tr,
                      maxLines: 1,
                      style: TextStyle(
                        // height: 1.5,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        fontFamily: "Bahij",
                      )),
            ],
          )),
    );
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     content: Text('Your message here'),
    //     duration: Duration(seconds: 4), // Duration to show the snackbar
    //   ),
    // );
  }
  // Get initial connection status

  // Show overlay notification for connectivity changes

  @override
  Widget build(BuildContext context) {
    return Container();
    // isshow == true
    //     ? Container(
    //         child: Center(
    //             child: _connectivityResult == ConnectivityResult.none
    //                 ? Text(
    //                     'No Internet Connection'.tr,
    //                     style: TextStyle(backgroundColor: Colors.red),
    //                   )
    //                 : Text(
    //                     'Internet Connection Available'.tr,
    //                     style: TextStyle(backgroundColor: Colors.green),
    //                   )),
    //       )
    //     : Container();
  }
}

void showConnectivityOverlay(ConnectivityResult connectivityResult) {
  String message = connectivityResult == ConnectivityResult.none
      ? 'No Internet Connection'
      : 'Internet Connection Available';
  showOverlayNotification((context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }, duration: Duration(seconds: 2));
}
