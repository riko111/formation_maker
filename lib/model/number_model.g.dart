// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointModel _$PointModelFromJson(Map<String, dynamic> json) => PointModel(
      top: (json['top'] as num).toDouble(),
      left: (json['left'] as num).toDouble(),
    );

Map<String, dynamic> _$PointModelToJson(PointModel instance) =>
    <String, dynamic>{
      'top': instance.top,
      'left': instance.left,
    };

SceneModel _$SceneModelFromJson(Map<String, dynamic> json) => SceneModel(
      (json['points'] as List<dynamic>)
          .map((e) => PointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneModelToJson(SceneModel instance) =>
    <String, dynamic>{
      'points': instance.points.map((e) => e.toJson()).toList(),
    };

NumberModel _$NumberModelFromJson(Map<String, dynamic> json) => NumberModel()
  ..serialNumber = json['serialNumber'] as String
  ..numberName = json['numberName'] as String
  ..dancerCount = json['dancerCount'] as int
  ..sceneCount = json['sceneCount'] as int
  ..stageWidth = json['stageWidth'] as int
  ..stageHeight = json['stageHeight'] as int
  ..tempo = json['tempo'] as int
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
      'sceneList': instance.sceneList.map((e) => e.toJson()).toList(),
    };
