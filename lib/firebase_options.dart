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
    apiKey: 'AIzaSyC_ZpCm9yzwA4kxI7OKXh8ZBfm4F8p9goc',
    appId: '1:852542786828:web:23eba886f90b50373b0d29',
    messagingSenderId: '852542786828',
    projectId: 'quiz-app-6840d',
    authDomain: 'quiz-app-6840d.firebaseapp.com',
    storageBucket: 'quiz-app-6840d.appspot.com',
    measurementId: 'G-Q0VDDE8KPM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPqIHSA0duiT6_vPBzpftJIEOajxoFZ4U',
    appId: '1:852542786828:android:83de78dd5950da2f3b0d29',
    messagingSenderId: '852542786828',
    projectId: 'quiz-app-6840d',
    storageBucket: 'quiz-app-6840d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC23HRMlLLQ3dv4qGIlsQQiMQhqAtRiH7o',
    appId: '1:852542786828:ios:68f359e55a3798203b0d29',
    messagingSenderId: '852542786828',
    projectId: 'quiz-app-6840d',
    storageBucket: 'quiz-app-6840d.appspot.com',
    iosClientId: '852542786828-7rm0mitvoja02sq5u4maf89gcipbo60a.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC23HRMlLLQ3dv4qGIlsQQiMQhqAtRiH7o',
    appId: '1:852542786828:ios:68f359e55a3798203b0d29',
    messagingSenderId: '852542786828',
    projectId: 'quiz-app-6840d',
    storageBucket: 'quiz-app-6840d.appspot.com',
    iosClientId: '852542786828-7rm0mitvoja02sq5u4maf89gcipbo60a.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizApp',
  );
}
