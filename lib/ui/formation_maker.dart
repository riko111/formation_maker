
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formation_maker/ui/page/file_list_page.dart';
import 'package:formation_maker/ui/page/home_page.dart';
import 'package:formation_maker/ui/page/number_page.dart';
import 'package:formation_maker/ui/page/setting_dancer_page.dart';
import 'package:formation_maker/viewmodel/dancer_view_model.dart';
import 'package:formation_maker/viewmodel/file_view_model.dart';

import '../config/size_config.dart';
import 'page/create_number_page.dart';

class FormationMakerApp extends StatelessWidget {
  const FormationMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    String title = '立ち位置くん';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const HomePage(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/create_number' : (context) => const CreateNumberPage(),
        '/file_list' : (context) => const FileListPage(),
        '/number' : (context) => const NumberPage(),
        '/setting_dancer' : (context) => const SettingDancerPage(),
      },
    );
  }
}

class NumberPageArguments{
  NumberPageArguments(this.fileViewModel, this.filePath);
  final FileViewModel fileViewModel;
  final File? filePath;
}

class SettingDancerPageArguments{
  SettingDancerPageArguments(this.dancerViewModel, this.num);
  final DancerViewModel dancerViewModel;
  final int num;
}