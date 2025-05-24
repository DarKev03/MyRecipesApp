import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageUploaderWidget extends StatefulWidget {
  final Function(String imageUrl) onImageUploaded;

  const ImageUploaderWidget({super.key, required this.onImageUploaded});

  @override
  _ImageUploaderWidgetState createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  bool _isLoading = false;
  bool _isUploaded = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() => _isLoading = true);

    final file = File(pickedFile.path);
    final fileBytes = await file.readAsBytes();
    final fileName = pickedFile.name;    

    final storage = Supabase.instance.client.storage.from('recipes');
    await storage.uploadBinary('images/$fileName', fileBytes,
        fileOptions: FileOptions(contentType: 'image/jpeg'));

    final publicUrl = storage.getPublicUrl('images/$fileName');

    setState(() {
      _isLoading = false;
      _isUploaded = true;
    });

    widget.onImageUploaded(publicUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          _isLoading ? null : _uploadImage();
        },
        icon: Icon(Icons.photo_camera, color: Colors.white),
        label: Text(_isUploaded ? 'Subida exitosa' : 'Subir imagen',
            style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: _isUploaded ? Colors.green : AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ));
  }
}
