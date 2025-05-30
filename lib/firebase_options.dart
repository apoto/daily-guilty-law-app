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
    apiKey: 'AIzaSyCe2wZB1FmMS95tPzyB8fwUIC94WNbArSA',
    appId: '1:376415137307:web:daily-guilty-law',
    messagingSenderId: '376415137307',
    projectId: 'daily-guilty-law',
    authDomain: 'daily-guilty-law.firebaseapp.com',
    storageBucket: 'daily-guilty-law.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCe2wZB1FmMS95tPzyB8fwUIC94WNbArSA',
    appId: '1:376415137307:android:daily-guilty-law',
    messagingSenderId: '376415137307',
    projectId: 'daily-guilty-law',
    storageBucket: 'daily-guilty-law.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCe2wZB1FmMS95tPzyB8fwUIC94WNbArSA',
    appId: '1:376415137307:ios:daily-guilty-law',
    messagingSenderId: '376415137307',
    projectId: 'daily-guilty-law',
    storageBucket: 'daily-guilty-law.appspot.com',
    iosBundleId: 'com.example.dailyGuiltyLaw',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCe2wZB1FmMS95tPzyB8fwUIC94WNbArSA',
    appId: '1:376415137307:macos:daily-guilty-law',
    messagingSenderId: '376415137307',
    projectId: 'daily-guilty-law',
    storageBucket: 'daily-guilty-law.appspot.com',
    iosBundleId: 'com.example.dailyGuiltyLaw',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCe2wZB1FmMS95tPzyB8fwUIC94WNbArSA',
    appId: '1:376415137307:windows:daily-guilty-law',
    messagingSenderId: '376415137307',
    projectId: 'daily-guilty-law',
    storageBucket: 'daily-guilty-law.appspot.com',
  );
}
