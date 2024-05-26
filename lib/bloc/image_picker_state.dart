import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerState extends Equatable {
  final XFile? file;
  final Map<Permission, PermissionStatus>? status;

  @override
  List<Object?> get props => [file,status];

  const ImagePickerState({this.file, this.status});

  ImagePickerState copyWith({XFile? file, Map<Permission, PermissionStatus>? status}) {
    return ImagePickerState(file: file ?? this.file, status: status ?? this.status);
  }
}
