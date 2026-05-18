import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/recipe_provider.dart';
import 'provider/theme_provider.dart'; 
import 'screens/recipe_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'TasteBud Recipe Box',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme, 
      home: const RecipeListScreen(),
    );
  }
}