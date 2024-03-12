import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool isDarkModes = false;
  Color backgroudcolor = Colors.white;
  Color textcolor = Colors.black;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      backgroudcolor = Colors.white;
      textcolor = Colors.black;
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      backgroudcolor = Colors.black;
      textcolor = Colors.white;
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    backgroudcolor = isOn ? Colors.black : Colors.white;
    textcolor = isOn ? Colors.white : Colors.black;
    isDarkModes != true;
    notifyListeners();
  }

  ThemeData _currentTheme = ThemeData.light();

  ThemeData get currentTheme => _currentTheme;
  bool _isFavorite = false;

  bool get favorite => _isFavorite;

  set isFavorites(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  static Icon _isFavoriteIcon = Icon(Icons.favorite);

  Icon get favoriteIcon => _isFavoriteIcon;

  set setisFavoritesIcon(Icon value) {
    _isFavoriteIcon = value;
    notifyListeners();
  }

  void isFavoriteFunction() {
    _isFavoriteIcon = _isFavoriteIcon == Icon(Icons.favorite, color: Colors.red)
        ? Icon(
            Icons.favorite_border,
          )
        : Icon(Icons.favorite, color: Colors.red);
    notifyListeners();
  }

  void toggleThemes() {
    _currentTheme = _currentTheme == ThemeData.light()
        ? ThemeData.dark()
        : ThemeData.light();
    notifyListeners();
  }
  // void toggleThemes() {
  //   if(themeMode==true)
  //    ThemeMode.dark =  !ThemeMode.light;
  //   notifyListeners();
  // }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}
