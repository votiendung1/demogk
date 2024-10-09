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
    apiKey: 'AIzaSyCfLaokorDtdCIsxuJdOqRHQ8vH8zTrlQc',
    appId: '1:1031458484873:web:25a50906c60c8b6d6fcc58',
    messagingSenderId: '1031458484873',
    projectId: 'fir-gk-634ab',
    authDomain: 'fir-gk-634ab.firebaseapp.com',
    storageBucket: 'fir-gk-634ab.appspot.com',
    measurementId: 'G-FGJXXBTEN3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJ42F-4D_Cyg9RZ372pRBmGBhWUb-rTXo',
    appId: '1:1031458484873:android:c8024bef1f4922506fcc58',
    messagingSenderId: '1031458484873',
    projectId: 'fir-gk-634ab',
    storageBucket: 'fir-gk-634ab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIrzxlZzEUjo3DAqEST4cnG1C3p8_q4Nw',
    appId: '1:1031458484873:ios:a0eb5c43217a11f46fcc58',
    messagingSenderId: '1031458484873',
    projectId: 'fir-gk-634ab',
    storageBucket: 'fir-gk-634ab.appspot.com',
    iosBundleId: 'com.example.demoGk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIrzxlZzEUjo3DAqEST4cnG1C3p8_q4Nw',
    appId: '1:1031458484873:ios:a0eb5c43217a11f46fcc58',
    messagingSenderId: '1031458484873',
    projectId: 'fir-gk-634ab',
    storageBucket: 'fir-gk-634ab.appspot.com',
    iosBundleId: 'com.example.demoGk',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCfLaokorDtdCIsxuJdOqRHQ8vH8zTrlQc',
    appId: '1:1031458484873:web:5d23bd5cd4541fbc6fcc58',
    messagingSenderId: '1031458484873',
    projectId: 'fir-gk-634ab',
    authDomain: 'fir-gk-634ab.firebaseapp.com',
    storageBucket: 'fir-gk-634ab.appspot.com',
    measurementId: 'G-7HH900NRKM',
  );
}
