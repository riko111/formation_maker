import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/model/number_model.dart';
import 'package:path_provider/path_provider.dart';

final ioProvider= ChangeNotifierProvider( (ref) => FileRepository(model:ref.read(numberModelProvider)),);


class FileRepository extends ChangeNotifier{
  late NumberModel model;
  FileRepository({required NumberModel model}){
    this.model = model;
    () async {
      final localPath = await getLocalPath;
      appPath = '$localPath/number/';
      appDirectory = Directory(appPath);

      await appDirectory.create(recursive: true);

      appDirectory.list().listen((FileSystemEntity entity) {
        appFileList.add(File(entity.path));
      });
    }();

  }
  late String appPath;
  late Directory appDirectory;
  final List<File> appFileList = [];
  late File file;

  /// ローカルパスの取得
  Future<String> get getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    notifyListeners();
    return directory.path;
  }

  Future<void> write() async {
    String serial = model.serialNumber;
    String title = model.numberName;

    file = File('$appPath${title}_$serial.json');
    await model.save(file);
  }

}
