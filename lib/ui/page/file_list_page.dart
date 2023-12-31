import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formation_maker/ui/formation_maker.dart';
import 'package:formation_maker/viewmodel/file_view_model.dart';

class FileListPage extends StatelessWidget{
  const FileListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final FileViewModel viewModel =  ModalRoute.of(context)?.settings.arguments as FileViewModel;
    List<File> list = viewModel.getFileList()!;
    if(list.isEmpty){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: '保存されているデータがありません');
    }

    List<String> fileNameList = [];
    for (var element in list) {
      String filePath = element.path;
      List<String> paths = filePath.split('/');
      String title = paths[paths.length-1].split('_')[0];
      fileNameList.add(title);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: fileNameList.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap:(){
                Navigator.pushNamed(context, '/number', arguments: NumberPageArguments(viewModel,list[index]));
              },
              child :Container(
                height:50,
                color: Colors.blueGrey,
                child: Text(
                  fileNameList[index],
                  style: const TextStyle(fontSize: 24),
                ),
              )
            );
          },
          separatorBuilder: (context, index){
            return const Divider();
          },
        ),
      ),
    );
  }

}