import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUsuarioWidget extends StatefulWidget {
  const ImageUsuarioWidget({super.key});

  @override
  State<ImageUsuarioWidget> createState() => _ImageUsuarioWidgetState();
}

class _ImageUsuarioWidgetState extends State<ImageUsuarioWidget> {
  List<File?> _images2 = [null];

  final picker = ImagePicker();

  Future getImage(int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _images2[index] = File(pickedFile.path);
      } else {
        print('No se seleccionó ninguna imagen.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => getImage(0),
        child: Container(
          margin: EdgeInsets.all(5),
          width: 125,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: _images2[0] == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/usuario_image.png'),
                    image: AssetImage('assets/img/usuario_image.png'),
                    fit: BoxFit.cover,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _images2[0]!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
