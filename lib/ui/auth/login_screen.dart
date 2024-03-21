import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ui/auth/login_with_phone_number.dart';
import 'package:login_app/ui/auth/signup_screen.dart';
import 'package:login_app/ui/posts/post_screen.dart';
import 'package:login_app/utils/utils.dart';
import 'package:login_app/widgets/round_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString()
    ).then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PostScreen()));
      setState(() {
        loading = false;
      });
    }
    ).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Log In'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.deepPurple,)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_outlined, color: Colors.deepPurple,)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the Password';
                        }
                        return null;
                      },
                    ),
                  ],
                )
            ),
            const SizedBox(height: 50,),
            RoundButton(
              title: 'Log In',
              loading: loading,
              onTap: (){
              if(_formKey.currentState!.validate()){
                login();
              }
            },),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("If you don't have account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SignUpScreen())
                  );
                },
                  child: const Text('Sign Up'),
                )
              ],
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginWithPhoneNumber()));
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)
                  ),
                  child: const Center ( child: Text('Login With Phone Number'))),
            ),
          ],
        ),
      ),
    );
  }
}
