import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formation_maker/const/colors.dart';
import 'package:formation_maker/util/point_util.dart';
import 'package:formation_maker/viewmodel/danver_view_model.dart';

class StageDancer extends StatefulWidget {
  const StageDancer({
    super.key,
    required this.dancerRadius,
    required this.boxSize,
    required this.width,
    required this.height,
    required this.num,
    required this.dancerViewModel,
    // required this.centerPoint,
    required this.cm,
  });

  final double dancerRadius;
  final double boxSize;
  final double width;
  final double height;
  final int num;
  final DancerViewModel dancerViewModel;

  // final Offset centerPoint;
  final double cm;

  @override
  State<StatefulWidget> createState() => _DragState();
}


class _DragState extends State<StageDancer> {
  @override
  Widget build(BuildContext context) {
    Offset offset = PointUtil.convertOffsetFromPoint(widget.dancerViewModel.xList[widget.num], widget.dancerViewModel.yList[widget.num], widget.cm);
    return Positioned(
      top: offset.dy,
      left: offset.dx,
      child:SizedBox.fromSize(
        size: Size(widget.dancerRadius*2, widget.dancerRadius*2),
        child: Draggable(
          feedback: Opacity(
            opacity: 0.5,
            child:  DancerContainer(
              dancerRadius: widget.dancerRadius,
              num: widget.num,
              name: widget.dancerViewModel.names[widget.num],
            ),
          ),
          child: DancerContainer(
            dancerRadius: widget.dancerRadius,
            num: widget.num,
            name: widget.dancerViewModel.names[widget.num],
          ),
          onDragEnd: (dragDetails){
            setState(() {
              List<double> movedPoint = PointUtil.convertPointFromOffset(dragDetails.offset, widget.cm);
              widget.dancerViewModel.xList[widget.num] = movedPoint[0];
              widget.dancerViewModel.yList[widget.num] = movedPoint[1];
            });
          },
        ),
      ),
    );
  }
}


class DancerContainer extends StatelessWidget{
  const DancerContainer({
    super.key,
    required this.dancerRadius,
    required this.num,
    required this.name,
  });

  final double dancerRadius;
  final int num;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color:DancerColors.colors[num],),
      ),
      child:Text(name , style: TextStyle(color: DancerColors.colors[num],fontSize: dancerRadius,)),
    );
  }
}
