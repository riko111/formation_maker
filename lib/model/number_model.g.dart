// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneModel _$SceneModelFromJson(Map<String, dynamic> json) => SceneModel(
      (json['points'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
    );

Map<String, dynamic> _$SceneModelToJson(SceneModel instance) =>
    <String, dynamic>{
      'points': instance.points,
    };

NumberModel _$NumberModelFromJson(Map<String, dynamic> json) => NumberModel()
  ..serialNumber = json['serialNumber'] as String
  ..numberName = json['numberName'] as String
  ..dancerCount = json['dancerCount'] as int
  ..sceneCount = json['sceneCount'] as int
  ..stageWidth = json['stageWidth'] as int
  ..stageHeight = json['stageHeight'] as int
  ..tempo = json['tempo'] as int
  ..dancerNameList =
      (json['dancerNameList'] as List<dynamic>).map((e) => e as String).toList()
  ..sceneList = (json['sceneList'] as List<dynamic>)
      .map((e) => SceneModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$NumberModelToJson(NumberModel instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'numberName': instance.numberName,
      'dancerCount': instance.dancerCount,
      'sceneCount': instance.sceneCount,
      'stageWidth': instance.stageWidth,
      'stageHeight': instance.stageHeight,
      'tempo': instance.tempo,
      'dancerNameList': instance.dancerNameList,
      'sceneList': instance.sceneList.map((e) => e.toJson()).toList(),
    };
