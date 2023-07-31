import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HitTestDetector extends SingleChildRenderObjectWidget {
  /// タッチされた際のコールバック
  final VoidCallback? onTouch;

  const HitTestDetector({
    Key? key,
    Widget? child,
    this.onTouch,
  }) : super(
    key: key,
    child: child,
  );

  @override
  RenderObject createRenderObject(BuildContext context) {
    return HitTestDetectorRenderBox()..onHit = onTouch;
  }

  @override
  void updateRenderObject(
      BuildContext context,
      covariant HitTestDetectorRenderBox renderObject,
      ) {
    super.updateRenderObject(context, renderObject);

    renderObject.onHit = onTouch;
  }
}

class HitTestDetectorRenderBox extends RenderProxyBox {
  VoidCallback? onHit;
}
