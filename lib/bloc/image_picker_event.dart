import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const ImagePickerEvent();
}

class TakePermission extends ImagePickerEvent {}

class CameraCapture extends ImagePickerEvent {}

class UploadFromGallery extends ImagePickerEvent {}
