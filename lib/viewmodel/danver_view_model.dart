import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/repository/dancer_repository.dart';

import '../model/number_model.dart';

final dancerViewModelProvider = ChangeNotifierProvider((ref) => DancerViewModel(repository: ref.read(dancerRepositoryProvider)));

class DancerViewModel extends ChangeNotifier {
  int _dancerCount = 0;
  final List<double> _tops = [];
  List<double> get tops => _tops;

  final List<double> _lefts = [];
  List<double> get lefts => _lefts;

  List<String> names = [];

  DancerRepository? repository;

  DancerViewModel({this.repository});

  bool initializedFlag = false;

  void initialize(int count, double size) {
    _dancerCount = count;
    for(int i=0; i<dancerCount; i++){
      _tops.add(0.0);
      _lefts.add(size * (i+1));
    }
    repository?.initialize(count,size);
  }

  void initializeList(NumberModel model,int sceneNum){
    if(initializedFlag) return;

    _dancerCount = model.dancerNameList.length;
    if(model.sceneList.isEmpty) {
      List<List<double>> points = [];
      for(int i=0; i<dancerCount; i++){
        _tops.add(0.0);
        _lefts.add(0.0);
        List<double> point = [0.0,0.0];
        points.add(point);
      }
      SceneModel sceneModel = SceneModel(points);
      model.sceneList.add(sceneModel);
    } else {
      List<List<double>> points = model.sceneList[sceneNum].points;
      for(int i=0; i<dancerCount; i++){
        if(_tops.length < i+1) {
          _tops.add(points[i][0]);
          _lefts.add(points[i][1]);
        } else {
          _tops[i] = points[i][0];
          _lefts[i] = points[i][1];
        }
      }
    }
    names = model.dancerNameList;
    repository?.initializeList(_tops, _lefts, names);
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
    for(int i=0; i<_tops.length; i++){
      List<double> point = [_tops[i], _lefts[i]];
      scene.points.add(point);
    }
  }


  int get dancerCount => _dancerCount;

  void changePoint(int count, double top, double left) {
    repository?.changePoint(count, top, left).then((value) {
      _tops[count] = value.tops[count];
      _lefts[count] = value.lefts[count];
      notifyListeners();
    });
  }

}