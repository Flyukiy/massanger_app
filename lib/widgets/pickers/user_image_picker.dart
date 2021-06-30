import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickerFn);
  final void Function(File pickedImage) imagePickerFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickerFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
      ),
      FlatButton.icon(
        textColor: Theme
            .of(context)
            .primaryColor,
        onPressed: _pickImage,
        label: Text('Add Image'),
        icon: Icon(Icons.image),
      ),
    ],);
  }
}
