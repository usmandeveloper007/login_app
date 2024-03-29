// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCwaI5u_hrAoMTLs_HhFEViS9sZWv9QKgM',
    appId: '1:187460714889:web:7d5bc978c8b1375e2a6158',
    messagingSenderId: '187460714889',
    projectId: 'login-authentication-1a58a',
    authDomain: 'login-authentication-1a58a.firebaseapp.com',
    storageBucket: 'login-authentication-1a58a.appspot.com',
    measurementId: 'G-SEF80518K3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALpBVI4JKnxTJ5EJlhhe7GbOx9DXbEJVE',
    appId: '1:187460714889:android:1b960430153c2a132a6158',
    messagingSenderId: '187460714889',
    projectId: 'login-authentication-1a58a',
    storageBucket: 'login-authentication-1a58a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqMYyu86AgX75MAx0DBpUu36gbvTmm_Bs',
    appId: '1:187460714889:ios:4a2e4ee92cfa291d2a6158',
    messagingSenderId: '187460714889',
    projectId: 'login-authentication-1a58a',
    storageBucket: 'login-authentication-1a58a.appspot.com',
    iosBundleId: 'com.example.loginApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqMYyu86AgX75MAx0DBpUu36gbvTmm_Bs',
    appId: '1:187460714889:ios:e59d09df4414de9e2a6158',
    messagingSenderId: '187460714889',
    projectId: 'login-authentication-1a58a',
    storageBucket: 'login-authentication-1a58a.appspot.com',
    iosBundleId: 'com.example.loginApp.RunnerTests',
  );
}
