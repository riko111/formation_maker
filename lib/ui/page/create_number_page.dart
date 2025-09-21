import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formation_maker/ui/formation_maker.dart';
import 'package:formation_maker/viewmodel/file_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CreateNumberPage extends HookConsumerWidget {

  const CreateNumberPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    final viewModel = ModalRoute.of(context)?.settings.arguments as FileViewModel;
    return getInner(context, viewModel);
  }

  Scaffold getInner(BuildContext context, FileViewModel viewModel){
    final nameController = useTextEditingController();

    String title;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
          child:ListView(
            //mainAxisSize: MainAxisSize.min,
            shrinkWrap: true,
            children: [
              TextFormField(
                autofocus: true,
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'タイトル',
                  errorMaxLines: 2,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // return 'Name must not be null or empty.';
                    return 'タイトルを入力してください。';
                  }
                  if (value.length > 10) {
                    return '';
                  }
                  return null;
                },
              ),
              /*TextFormField(
                controller: numberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: '人数',
                  errorMaxLines: 2,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // return 'Number must not be null or empty.';
                    return '人数を入力してください。';
                  }
                  if (int.tryParse(value) == null) {
                    return '整数を入力してください。';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tempoController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'テンポ(BPM)',
                  errorMaxLines: 2,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // return 'Number must not be null or empty.';
                    return 'テンポを入力してください。';
                  }
                  if (int.tryParse(value) == null) {
                    return '整数を入力してください。';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: widthController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: '幅(cm)',
                  errorMaxLines: 2,
                ),
                validator: (value){
                  if (value != null &&value.isNotEmpty &&  int.tryParse(value) == null) {
                    return '整数を入力してください。';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: '奥行(cm)',
                  errorMaxLines: 2,
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty && int.tryParse(value) == null) {
                    return '整数を入力してください。';
                  }
                  return null;
                }
              ),*/
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: ()=>{Navigator.pop(context)},
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text('cancel'),
                  ),
                  const SizedBox(width: 10,),
                  TextButton(
                    onPressed: () async {
                      title = nameController.text;
                      if (title.isNotEmpty) {
                        await viewModel.createFile(title);
                        if (!context.mounted) {
                          return;
                        }
                        Navigator.pushReplacementNamed(context, '/number',
                            arguments: NumberPageArguments(viewModel, null));
                      } else {
                        nameController.text = ' ';
                        nameController.text = '';
                      }
                    },

                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      side: const BorderSide(color: Colors.black45),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text('Create'),
                  ),

                ],
              )
            ],
          ),
        ),
    );
  }

}