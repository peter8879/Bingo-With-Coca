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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAmIzenHP7by8suZQoRkkwWiF1i5jOPQJ0',
    appId: '1:360873882640:web:b871cbff6574f3341c0695',
    messagingSenderId: '360873882640',
    projectId: 'bingo-with-coca',
    authDomain: 'bingo-with-coca.firebaseapp.com',
    storageBucket: 'bingo-with-coca.firebasestorage.app',
    measurementId: 'G-2ZEQRZXQLS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfyX5Q7YK5IhM-9JsSAyFiJR0dOge8W10',
    appId: '1:360873882640:android:3e540d459dc5e26e1c0695',
    messagingSenderId: '360873882640',
    projectId: 'bingo-with-coca',
    storageBucket: 'bingo-with-coca.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbTUJzYS019ZYvNXe0Z3yfWKE5GC0EsTE',
    appId: '1:360873882640:ios:c11169a09045088d1c0695',
    messagingSenderId: '360873882640',
    projectId: 'bingo-with-coca',
    storageBucket: 'bingo-with-coca.firebasestorage.app',
    iosBundleId: 'com.example.bingoWithCoca',
  );
}
