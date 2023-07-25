import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/model/number_model.dart';
import 'package:formation_maker/repository/file_repository.dart';
import 'package:intl/intl.dart';

final fileViewModelProvider = Provider((ref) => FileViewModel(repository: ref.read(ioProvider)));

class FileViewModel {
  FileRepository? repository;
  FileViewModel({this.repository});

  void createFile(String numberName, int dancerCount, int stageWidth, int stageHeight, int tempo){
    DateTime dateTime = DateTime.timestamp();
    String strDate = DateFormat('yyyyMMddhhmmss').format(dateTime);
    String serialNumber = strDate + generateRandomString();
    NumberModel model = NumberModel.name(serialNumber, numberName, dancerCount, 1, stageWidth, stageHeight,tempo);
    repository?.model = model;
    repository?.write;
  }

  String generateRandomString(){
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    final randomStr =  List.generate(3, (_) => charset[random.nextInt(charset.length)]).join();
    return randomStr;
  }

  String? getFilePath(){
    return repository?.appDirectory.path.toString();
  }

  List<File>? getFileList(){
    return repository?.appFileList;
  }

  File? getFile(){
    return repository?.file;
  }

}