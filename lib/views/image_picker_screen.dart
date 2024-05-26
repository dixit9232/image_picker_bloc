import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_bloc/bloc/image_picker_bloc.dart';
import 'package:image_picker_bloc/bloc/image_picker_event.dart';
import 'package:image_picker_bloc/bloc/image_picker_state.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ImagePickerBloc>().add(TakePermission());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state.file == null) {
                  return const Text(
                    "Upload image",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                } else {
                    return SizedBox(
                      height: 300,
                      width: 150,
                      child: Image.file(
                        File(state.file!.path.toString()),
                      ));
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      context.read<ImagePickerBloc>().add(CameraCapture());
                    },
                    icon: const Icon(Icons.camera)),
                IconButton(
                    onPressed: () {
                      context.read<ImagePickerBloc>().add(UploadFromGallery());
                    },
                    icon: const Icon(Icons.image)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
