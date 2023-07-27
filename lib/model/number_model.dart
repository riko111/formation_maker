
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'number_model.g.dart';

final numberModelProvider = Provider((ref) => NumberModel());
//
// @JsonSerializable()
// class PointModel { // 場面ごとの1人分の座標位置を保持するクラス
//   double top;
//   double left;
//   PointModel({required this.top, required this.left});
//
//   factory PointModel.fromJson(Map<String, dynamic> json) =>
//       _$PointModelFromJson(json);
//   Map<String, dynamic> toJson() => _$PointModelToJson(this);
// }

@JsonSerializable(explicitToJson: true)
class SceneModel { // 1場面を保持するクラス
  List<List<double>> points = [];
  SceneModel(this.points);

  factory SceneModel.fromJson(Map<String, dynamic> json) =>
      _$SceneModelFromJson(json);
  Map<String, dynamic> toJson() => _$SceneModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NumberModel{ // 曲ごとのデータを保持するクラス
  static final NumberModel _instance = NumberModel._internal().._setDefault();
  late String serialNumber;
  late String numberName;

  late int dancerCount;
  late int sceneCount;

  late int stageWidth;
  late int stageHeight;

  late int tempo;

  List<String> dancerNameList =[];
  List<SceneModel> sceneList = [];
  //FileRepository? repository;
  NumberModel._internal();
  factory NumberModel() => _instance;

  NumberModel.set(this.serialNumber, this.numberName, this.dancerCount,
      this.sceneCount, this.stageWidth, this.stageHeight, this.tempo){
    for(int i=0; i<dancerCount; i++){
      dancerNameList.add((i+1).toString());
    }
  }

  factory NumberModel.fromJson(Map<String,dynamic> json) =>
      _$NumberModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberModelToJson(this);

  Future load(File file) async {
    if(!(await file.exists())) {
      _setDefault();
      return;
    }

    final json = await file.readAsString();
    return _$NumberModelFromJson(jsonDecode(json));
  }


  Future save(File file) async {
    final json = jsonEncode(_$NumberModelToJson(this));
    await file.writeAsString(json);
  }

  void _setDefault(){
    stageWidth = 900;
    stageHeight = 450;
    dancerCount = 10;
  }
}

