import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/ui/formation_maker.dart';

/// ダンサーさん設定画面
class SettingDancerPage extends ConsumerWidget {
  const SettingDancerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as SettingDancerPageArguments;
    final dancerViewModel = args.dancerViewModel;
    final num = args.num;

    return WillPopScope(
      onWillPop: () async{  //戻るボタン無効
        return false;
      },
      child: Container(),
    );
  }

}