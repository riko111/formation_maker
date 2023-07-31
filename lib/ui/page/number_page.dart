import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/config/size_config.dart';
import 'package:formation_maker/model/number_model.dart';
import 'package:formation_maker/ui/formation_maker.dart';
import 'package:formation_maker/ui/widget/stage/stage.dart';
import 'package:formation_maker/viewmodel/file_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../viewmodel/danver_view_model.dart';

class NumberPage extends ConsumerWidget {
  const NumberPage({super.key});

  Future<NumberModel> initializer(
      FileViewModel fileViewModel, File? filePath) async {
    NumberModel numberModel = NumberModel();
    filePath ??= fileViewModel.getFile();
    await numberModel.load(filePath!);
    return numberModel;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    final args =
        ModalRoute.of(context)?.settings.arguments as NumberPageArguments;
    final FileViewModel fileViewModel = args.fileViewModel;
    final File? filePath = args.filePath;

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final dancerViewModel = ref.watch(dancerViewModelProvider);

    return FutureBuilder(
      future: initializer(fileViewModel, filePath),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return _loadingWidget(100);
        } else if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
          NumberModel numberModel = snapshot.data!;
          dancerViewModel.initializeList(numberModel);
          return drawView(context, numberModel, dancerViewModel, fileViewModel, deviceHeight, deviceWidth);
        } else {
          return const Text('');
        }
      },
    );
  }

  /// 画面全体
  WillPopScope drawView(
      BuildContext context,
      NumberModel numberModel,
      DancerViewModel dancerViewModel,
      FileViewModel fileViewModel,
      double deviceHeight,
      double deviceWidth,) {
    int xCount = numberModel.stageWidth ~/ 90;
    int yCount = numberModel.stageHeight ~/ 90;


    return WillPopScope(
      onWillPop: () async {
        dancerViewModel.setList(numberModel, 0);
        dancerViewModel.initializedFlag=false;
        fileViewModel.updateFile(numberModel);
        return true;
      },

      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Consumer(builder: (context, ref, child) {
              //return const Text('data');
              return Stage(xCount: xCount, yCount: yCount,specWidth: numberModel.stageWidth, specHeight: numberModel.stageHeight, dancerViewModel: dancerViewModel);
            }),
            drawButtons(dancerViewModel, numberModel, fileViewModel, xCount.toDouble(), yCount.toDouble())
          ]),
        )
      ),
    );
  }


  ///ボタン描画
  Row drawButtons(DancerViewModel dancerViewModel, NumberModel numberModel, FileViewModel fileViewModel, double xCount, double yCount){
    var iconSize = SizeConfig.safeBlockVertical! * 20;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: ()=>{
            addMember(dancerViewModel),
          },
          icon: const Icon(Icons.person_add),
          tooltip: "メンバー追加",
          iconSize: iconSize,
        ),

        TextButton(
            onPressed: () => {
              dancerViewModel.setList(numberModel, 0),
              fileViewModel.updateFile(numberModel),
            },
            child: const Text('save')),
      ],
    );
  }
  void addMember(DancerViewModel dancerViewModel){
    dancerViewModel.addDancer(SizeConfig.blockSizeHorizontal!*2, SizeConfig.safeAreaTop! + SizeConfig.safeBlockVertical!*2);
  }

  Widget _loadingWidget(double size) {
    return Center(
      child: LoadingAnimationWidget.beat(
        color: Colors.blue,
        size: size,
      ),
    );
  }
}
