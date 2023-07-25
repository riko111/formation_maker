
import 'package:flutter/material.dart';
import 'package:formation_maker/ui/home_page.dart';

class FormationMakerApp extends StatelessWidget {
  const FormationMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    String title = '立ち位置くん';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}