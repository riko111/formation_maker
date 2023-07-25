
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formation_maker/ui/create_number_page.dart';
import 'package:formation_maker/ui/file_list_page.dart';
import 'package:formation_maker/viewmodel/file_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FileViewModel viewModel = ref.watch(fileViewModelProvider);

    //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){
                //showDialog(barrierDismissible:false,context: context, builder: (context) => CreateNumberPage(super.key,  viewModel));
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CreateNumberPage(viewModel:viewModel)));
              },
              icon: const Icon(Icons.add_circle_outline),
              tooltip: '新規作成',
              iconSize: 40,
              color: Colors.black45,

            ),
            IconButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => FileListPage(viewModel: viewModel)));
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