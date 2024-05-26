import 'package:bloc/bloc.dart';
import 'package:image_picker_bloc/bloc/image_picker_event.dart';
import 'package:image_picker_bloc/bloc/image_picker_state.dart';
import 'package:image_picker_bloc/utils/print_function.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/image_picker_utils.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(super.initialState, this.imagePickerUtils) {
    on<TakePermission>(_takePermission);
    on<CameraCapture>(_cameraCapture);
    on<UploadFromGallery>(_uploadFromGallery);
  }

  Future<void> _takePermission(TakePermission event, Emitter<ImagePickerState> emit) async {
    try {
      Map<Permission, PermissionStatus> status = await [
        Permission.camera,
        Permission.photos,
      ].request();
      emit(state.copyWith(status: status));
      state.status!.entries.map(
        (e) {
          cp("Permission : ${e.value.isGranted}");
        },
      );
    } catch (e) {
      cp("Error : ${e.toString()}");
    }
  }

  Future<void> _cameraCapture(CameraCapture event, Emitter<ImagePickerState> emit) async {
    if (await Permission.camera.status.isGranted) {
      emit(state.copyWith(file: await imagePickerUtils.getFromCamera()));
    } else {
      if (await Permission.camera.status.isPermanentlyDenied) {
        openAppSettings();
      } else {
        Permission.camera.request();
      }
    }
  }

  Future<void> _uploadFromGallery(UploadFromGallery event, Emitter<ImagePickerState> emit) async {
    if (await Permission.photos.status.isGranted) {
      emit(state.copyWith(file: await imagePickerUtils.getFromGallery()));
    } else {
      if (await Permission.photos.status.isPermanentlyDenied) {
        openAppSettings();
      } else {
        Permission.photos.request();
      }
    }
  }
}
