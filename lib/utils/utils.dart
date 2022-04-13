import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource src) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: src);

  if (_file != null) return await _file.readAsBytes();

  if (kDebugMode) {
    print('No image selected');
  }
}
