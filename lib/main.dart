import 'package:flutter/material.dart';
import 'package:qrcodescanner/components/theme.dart';
import 'package:qrcodescanner/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:qrcodescanner/components/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      home: const Home(),
    );
  }
}
