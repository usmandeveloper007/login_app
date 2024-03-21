import 'package:flutter/material.dart';
import 'package:login_app/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Center(
        child: Text("Splash Screen", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
