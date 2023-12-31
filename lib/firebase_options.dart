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
    apiKey: 'AIzaSyD8WzV9W6_QFd8f2fEqbzkgpHauvSkkis8',
    appId: '1:325719993672:web:6896574c5e89983b03977d',
    messagingSenderId: '325719993672',
    projectId: 'flutter-workshop-swg10g2',
    authDomain: 'flutter-workshop-swg10g2.firebaseapp.com',
    databaseURL: 'https://flutter-workshop-swg10g2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-workshop-swg10g2.appspot.com',
    measurementId: 'G-1Y3TE8TVPM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCaHCnRgr6DR-7ve0OCHO955ZGbkfYwVs',
    appId: '1:325719993672:android:501a0054e85921d103977d',
    messagingSenderId: '325719993672',
    projectId: 'flutter-workshop-swg10g2',
    databaseURL: 'https://flutter-workshop-swg10g2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-workshop-swg10g2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCptgoi5CO6msiDRtim2apxhgjEFZ5bdDg',
    appId: '1:325719993672:ios:d22b28a92309b9bd03977d',
    messagingSenderId: '325719993672',
    projectId: 'flutter-workshop-swg10g2',
    databaseURL: 'https://flutter-workshop-swg10g2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-workshop-swg10g2.appspot.com',
    iosClientId: '325719993672-7anf5gi9si92h69rc318p6ej5noermi3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterWorkshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCptgoi5CO6msiDRtim2apxhgjEFZ5bdDg',
    appId: '1:325719993672:ios:7ee7c667d699e6f203977d',
    messagingSenderId: '325719993672',
    projectId: 'flutter-workshop-swg10g2',
    databaseURL: 'https://flutter-workshop-swg10g2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-workshop-swg10g2.appspot.com',
    iosClientId: '325719993672-9ac1otebdeee0l6trikdovokk7ttlrfn.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterWorkshop.RunnerTests',
  );
}
