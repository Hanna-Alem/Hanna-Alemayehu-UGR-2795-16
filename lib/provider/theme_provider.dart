import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  //color scheme definitions
  final Color slideNeutralGray = const Color(0xFFF3F3F3); 
  final Color slideLightGray = const Color(0xFFC7C7C7); 
  final Color slideAccentMutedMauve = const Color(0xFFE9E0E2); 
  final Color slideDarkMauve = const Color(0xFF786266); 
  final Color slideNearWhite = const Color(0xFFFFFFFF); 

  ThemeData get currentTheme {
    if (_isDarkMode) {
      return ThemeData.dark().copyWith(
        primaryColor: slideNeutralGray,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A), 
        cardColor: const Color(0xFF252525), 
        
        colorScheme: ColorScheme.dark().copyWith(
          secondary: slideAccentMutedMauve,
        ),
        iconTheme: IconThemeData(color: slideLightGray),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );
    } else {
      return ThemeData.light().copyWith(
        primaryColor: slideNeutralGray,
        scaffoldBackgroundColor: slideNearWhite,
        cardColor: slideNeutralGray, 
        
       
        colorScheme: ColorScheme.light().copyWith(
          primary: slideLightGray, 
          secondary: slideDarkMauve, 
          surface: slideNeutralGray, 
        ),
        
        iconTheme: IconThemeData(color: slideLightGray), 
        
        appBarTheme: AppBarTheme(
          backgroundColor: slideNearWhite, 
          foregroundColor: Colors.black87, 
          elevation: 1, 
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
      );
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}