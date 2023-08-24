import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class ImageUsuarioWidget extends StatefulWidget {
  const ImageUsuarioWidget({Key? key}) : super(key: key);

  @override
  State<ImageUsuarioWidget> createState() => _ImageUsuarioWidgetState();
}

class _ImageUsuarioWidgetState extends State<ImageUsuarioWidget> {
  File? images2;

  final picker = ImagePicker();

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        images2 = File(pickedFile.path);

        final userInfoProvider =
            Provider.of<UserInfoProvider>(context, listen: false);
        userInfoProvider.userInfo.fotos = images2!;
      });
    } else {
      print('No se seleccionó ninguna imagen.');
    }
  }

  @override
  void dispose() {
    images2?.delete(); // Elimina la imagen capturada al cerrar el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => _getImage(),
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
          child: images2 == null
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
                    images2!, // Convierte la ruta en un objeto File
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
