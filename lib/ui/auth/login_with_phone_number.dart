import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ui/auth/verify_code.dart';
import 'package:login_app/utils/utils.dart';
import 'package:login_app/widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final phoneNumberController = TextEditingController();

  void verifyPhoneNumber(){
    setState(() {
      loading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text.toString(),
        verificationCompleted: (_){
          setState(() {
            loading = false;
          });
          },
        verificationFailed: (e){
          Utils().toastMessage(e.toString());
          setState(() {
            loading = false;
          });
          },
        codeSent: (String verificationId, int? token){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(verificationId: verificationId,)));
          setState(() {
            loading = false;
          });
          },
        codeAutoRetrievalTimeout: (e){
          Utils().toastMessage(e.toString());
          setState(() {
            loading = false;
          });
        }
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '+92 300 1234567'
              ),
            ),
            const SizedBox(height: 50,),
            RoundButton(
                title: 'Login',
                loading: loading,
                onTap: (){
                  verifyPhoneNumber();
                  },
              )
          ],
        ),
      ),
    );
  }
}
