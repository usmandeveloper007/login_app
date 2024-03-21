import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ui/auth/login_screen.dart';
import 'package:login_app/utils/utils.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogInScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          },
              icon: const Icon(Icons.logout_outlined)),
          const SizedBox(width: 10,)
        ],
      ),
    );
  }
}
