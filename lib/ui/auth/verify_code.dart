import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ui/posts/post_screen.dart';
import 'package:login_app/utils/utils.dart';
import 'package:login_app/widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final smsCodeController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextFormField(
              controller: smsCodeController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  hintText: '6 digit code'
              ),
            ),
            const SizedBox(height: 50,),
            RoundButton(
              title: 'Verify',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final token = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: smsCodeController.text.toString(),
                );
                try{
                  await auth.signInWithCredential(token);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PostScreen()));
                }catch (e){
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
