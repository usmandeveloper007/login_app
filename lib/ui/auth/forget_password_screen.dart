import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/utils/utils.dart';
import 'package:login_app/widgets/round_button.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forget Password'),centerTitle: true, automaticallyImplyLeading: false,),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 40,),
            RoundButton(title: 'Forget', onTap: (){
              _auth.sendPasswordResetEmail(email: _emailController.text.toString()).then((value){
                Utils().toastMessage('We have send you email to recover password, please check email');
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            }),
          ],
        ),
      ),
    );
  }
}
