import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_meal_app/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 131, 57, 8),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

// final themeRed = ThemeData(
//   useMaterial3: true,
//   // colorScheme: ColorScheme.fromSeed(
//   //   seedColor: Colors.blue,
//   //   brightness: Brightness.light,
//   // ),
//   colorSchemeSeed: Colors.blue,
//   brightness: Brightness.dark,
//   textTheme: GoogleFonts.latoTextTheme(),
// );

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Meal App',
      theme: theme,
      home: const TabScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}