import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_app/ui/auth/login_screen.dart';
import 'package:login_app/utils/utils.dart';
import 'package:login_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  void signup(){
    setState(() {
      loading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString()
    ).then((value){
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Congratulations! Account Created');
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
    return PopScope(
      canPop: true,
      onPopInvoked: (canPop){
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('SignUp'),
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
              RoundButton(title: 'Sign Up',
                loading: loading,
                onTap: (){
                if(_formKey.currentState!.validate()){
                    signup();
                  }
                }),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const LogInScreen())
                    );
                    },
                      child: const Text('Log In'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
