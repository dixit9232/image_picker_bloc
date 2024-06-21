import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_bloc/bloc/image_picker_bloc.dart';
import 'package:image_picker_bloc/bloc/image_picker_state.dart';
import 'package:image_picker_bloc/utils/image_picker_utils.dart';
import 'package:image_picker_bloc/views/image_picker_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerBloc(const ImagePickerState(), ImagePickerUtils()),
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: ImagePickerScreen(),
      ),
    );
  }
}

