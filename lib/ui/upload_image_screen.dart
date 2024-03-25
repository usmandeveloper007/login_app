import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_app/utils/utils.dart';
import 'package:login_app/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}


class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final imagePicker = ImagePicker();

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Posts');

  Future getGalleryImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80, );
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        Utils().toastMessage('no image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getGalleryImage();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple)
                  ),
                  child: _image != null ? Image.file(_image!.absolute) : const Center( child: Icon(Icons.image),),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            RoundButton(title: 'Upload',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true ;
                  });
                  firebase_storage.Reference ref =
                  firebase_storage.FirebaseStorage.instance.ref("/profileImages/${DateTime.now().millisecondsSinceEpoch}");
                  firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute, firebase_storage.SettableMetadata(contentType: 'image/jpeg'));
                  Future.value(uploadTask).then((value) async {
                    var newURL =  await  ref.getDownloadURL();
                    String userId = DateTime.now().millisecondsSinceEpoch.toString();
                    databaseRef.child(userId).set(
                    {
                      'id' : userId,
                      'imagePath' : newURL.toString(),
                    }
                ).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Image Added');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              }).onError((error, stackTrace) {
                setState(() {
                  loading = false;
                });
                Utils().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}
