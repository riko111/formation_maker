import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/model/dancer_model.dart';
import 'package:formation_maker/repository/dancer_repository.dart';

import '../model/number_model.dart';

final dancerViewModelProvider = ChangeNotifierProvider((ref) => DancerViewModel(repository: ref.read(dancerRepositoryProvider)));

class DancerViewModel extends ChangeNotifier {
  int _dancerCount = 0;
  final List<double> _yList = [];
  List<double> get yList => _yList;

  final List<double> _xList = [];
  List<double> get xList => _xList;

  List<String> names = [];
  List<int> colors = [];

  DancerRepository? repository;

  DancerViewModel({this.repository});

  bool initializedFlag = false;

  void initializeList(NumberModel model){
   if(initializedFlag) return;
   _yList.clear();
   _xList.clear();

    _dancerCount = model.dancerNameList.length;
    if(model.sceneList.isEmpty) {
      List<List<double>> points = [];
      for(int i=0; i<dancerCount; i++){
        _yList.add(0.0);
        _xList.add(0.0);
        List<double> point = [0.0,0.0];
        points.add(point);
      }
      SceneModel sceneModel = SceneModel(points);
      model.sceneList.add(sceneModel);
    } else {
      for(int i=0; i<model.sceneList.length; i++){
        List<List<double>> points = model.sceneList[i].points;
        for(int i=0; i<dancerCount; i++) {
          _yList.add(points[i][1]);
          _xList.add(points[i][0]);
        }
      }
    }
    names = model.dancerNameList;
    colors = model.dancerColorList;
    repository?.initializeList(_yList, _xList, names);
    initializedFlag = true;
  }

  void setList(NumberModel numberModel, int num) {
    var list = numberModel.sceneList;
    SceneModel scene;
    if(list.isEmpty) {
      scene = SceneModel([]);
      list.add(scene);
    } else {
      scene = list[num];
    }
    scene.points = [];
    for(int i=0; i<_yList.length; i++){
      List<double> point = [_xList[i], _yList[i]];
      scene.points.add(point);
    }
    numberModel.sceneCount = list.length;
    numberModel.dancerCount = names.length;
    numberModel.dancerNameList = names;
    numberModel.dancerColorList = colors;
  }


  int get dancerCount => _dancerCount;

  void changePoint(int count, double top, double left) {
    repository?.changePoint(count, top, left).then((dancerModel) {
      _xList.add(dancerModel[count].point[0]);
      _yList.add(dancerModel[count].point[1]);
      notifyListeners();
    });
  }

  void addDancer(double x, double y){
    repository?.addDancer(x,y).then((dancerModelList) {
      DancerModel dancerModel = dancerModelList[dancerCount];
      _xList.add(dancerModel.point[0]);
      _yList.add(dancerModel.point[1]);
      names.add(dancerModel.name);
      colors.add(dancerModel.color);
      ++_dancerCount;
      notifyListeners();
    });
  }
}