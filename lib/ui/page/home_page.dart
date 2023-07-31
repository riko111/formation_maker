
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/viewmodel/file_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../formation_maker.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    FileViewModel viewModel = ref.watch(fileViewModelProvider);
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () =>
                Navigator.pushNamed(context, '/create_number',arguments: viewModel),
              icon: const Icon(Icons.add_circle_outline),
              tooltip: '新規作成',
              iconSize: 40,
              color: Colors.black45,

            ),
            IconButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/file_list',arguments: viewModel);
              },
              icon: const Icon(Icons.file_open),
              tooltip: '開く',
              iconSize: 40,
              color: Colors.black45,
            ),
          ],
        ),
      )
    );
  }


}