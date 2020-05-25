import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;


class filePikerBussiness {

  Future<Map<String,dynamic>> filePicker(BuildContext context) async {
    try {
      File  file = await FilePicker.getFile(type: FileType.image);
//      setState(() {
//        fileName = p.basename(file.path);
//      });
      // print(fileName);
    //  return await _uploadFile(file, p.basename(file.path));
      print('cdcdcdcdc: ${p.basename(file.path)}');
      return{'file':file,'filename':p.basename(file.path)};
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }

  Future<String> uploadFile(File file, String filename) async {

    StorageReference storageReference;
    storageReference =
        FirebaseStorage.instance.ref().child("images/$filename");
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    return (await downloadUrl.ref.getDownloadURL());
  }
}

