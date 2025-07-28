import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/ui/widget/stage/stage_dancer.dart';
import 'package:formation_maker/ui/widget/stage/stage_floor.dart';
import 'package:formation_maker/ui/widget/stage/stage_x_axis.dart';
import 'package:formation_maker/ui/widget/stage/stage_y_axis.dart';
import 'package:formation_maker/viewmodel/dancer_view_model.dart';

import '../../../config/size_config.dart';

class Stage extends ConsumerWidget {
  const Stage(
      {super.key,
      required this.xCount,
      required this.yCount,
      required this.specWidth,
      required this.specHeight,
      required this.dancerViewModel});

  final int xCount; //縦割りの数
  final int yCount; //横割りの数
  final int specWidth; //指定の舞台幅
  final int specHeight; //指定の舞台奥行
  final DancerViewModel dancerViewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 舞台描画出来るサイズ
    // double tmpHeight = SizeConfig.safeBlockVertical! * 70;
    // double tmpWidth = SizeConfig.safeBlockHorizontal! * 80;

    // 1cmに相当するポイント
    double cm;
    if (SizeConfig.safeAreaWidth! / (specWidth+180) <  SizeConfig.safeBlockVertical!*70 / (specHeight+90)) {
      cm = SizeConfig.safeAreaWidth! / (specWidth+180);
    } else {
      cm = SizeConfig.safeBlockVertical!*70 / (specHeight+90);
    }

    // 1マス分の大きさ
    double boxSize = cm * 90;
    // 舞台サイズ
    double stageHeight = cm * specHeight;
    double stageWidth = cm * specWidth;

    // ダンサー円の半径
    double dancerRadius = cm * 35;

    //舞台センターポイント
    Offset centerPoint = Offset(SizeConfig.safeBlockHorizontal!*50, SizeConfig.safeBlockVertical!*35);

    return SizedBox(
      key: ValueKey(xCount),
      height: SizeConfig.safeBlockVertical! * 70,
      width: SizeConfig.safeBlockHorizontal! * 100,
      child: Stack(
        children: [
          StageFloor(width: stageWidth, height: stageHeight),
          StageXAxis(
              xCount: xCount,
              yCount: yCount,
              boxSize: boxSize,
              height: stageHeight),
          StageYAxis(
              scaleCount: yCount,
              boxSize: boxSize,
              width: stageWidth,
              height: stageHeight),
          for (int i = 0; i < dancerViewModel.dancerCount; i++)
            StageDancer(
              dancerRadius: dancerRadius,
              boxSize: boxSize,
              width: stageWidth,
              height: stageHeight,
              num: i,
              dancerViewModel: dancerViewModel,
              centerPoint: centerPoint,
              cm: cm,
            ),
        ],
      ),
    );
  }
}
