// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDgIR1JSXO8hbSL-lLhUyTwufOgd1H_WfA',
    appId: '1:602882038027:web:36f8e305515944170f6a0e',
    messagingSenderId: '602882038027',
    projectId: 'chansa2-c682b',
    authDomain: 'chansa2-c682b.firebaseapp.com',
    storageBucket: 'chansa2-c682b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-aNaUg6ERARUkD7UVOJkXintL1Mg1tOg',
    appId: '1:602882038027:android:963161e7ab400bc10f6a0e',
    messagingSenderId: '602882038027',
    projectId: 'chansa2-c682b',
    storageBucket: 'chansa2-c682b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk0C1DpEWydWdiQ_hAToTzyMPqiMj2wH4',
    appId: '1:602882038027:ios:5801daa3d33f9f080f6a0e',
    messagingSenderId: '602882038027',
    projectId: 'chansa2-c682b',
    storageBucket: 'chansa2-c682b.appspot.com',
    iosBundleId: 'com.example.chansaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBk0C1DpEWydWdiQ_hAToTzyMPqiMj2wH4',
    appId: '1:602882038027:ios:5801daa3d33f9f080f6a0e',
    messagingSenderId: '602882038027',
    projectId: 'chansa2-c682b',
    storageBucket: 'chansa2-c682b.appspot.com',
    iosBundleId: 'com.example.chansaApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDgIR1JSXO8hbSL-lLhUyTwufOgd1H_WfA',
    appId: '1:602882038027:web:1c36fc73d7bfebb10f6a0e',
    messagingSenderId: '602882038027',
    projectId: 'chansa2-c682b',
    authDomain: 'chansa2-c682b.firebaseapp.com',
    storageBucket: 'chansa2-c682b.appspot.com',
  );
}
