import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hurriyat/localstring.dart';
import 'package:hurriyat/pages/home.dart';
import 'package:flutter/services.dart';
import 'package:hurriyat/utils/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
// this is something new
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider notifier, child) {
          final controller = Provider.of<ThemeProvider>(context, listen: false);
          return GetMaterialApp(
            transitionDuration: Duration(days: 30),
            locale: Get.deviceLocale,
            enableLog: true,

            translations: Localstring(),
            themeMode: ThemeMode.system,
            color: Colors.teal,
            darkTheme: MyThemes.darkTheme,
            // controller.darkLight ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            // title: ',
            theme: controller.currentTheme,

            home: Home(),
          );
        },
      ),
    );
  }
}
