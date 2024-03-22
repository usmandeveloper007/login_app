import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_app/utils/utils.dart';
import 'package:login_app/widgets/round_button.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Posts');
  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true;
                  });
              databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set(
                {
                  'id' : DateTime.now().millisecondsSinceEpoch.toString(),
                  'message' : postController.text.toString(),
                }
              ).then((value) {
                setState(() {
                  loading = false;
                });
                Utils().toastMessage('Post Added');
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
