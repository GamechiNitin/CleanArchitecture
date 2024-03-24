import 'dart:io';
import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class GetImage {
  static Future<File?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
