// This is a template file for Firebase configuration
// Copy this file to firebase_options.dart and replace the placeholder values
// with your actual Firebase project configuration
//
// Run 'flutterfire configure' to generate the correct values automatically
// Or get them from your Firebase Console -> Project Settings -> Your Apps

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
    apiKey: 'your-web-api-key-here',
    appId: 'your-web-app-id-here',
    messagingSenderId: 'your-sender-id-here',
    projectId: 'your-project-id-here',
    authDomain: 'your-project-id.firebaseapp.com',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your-android-api-key-here',
    appId: 'your-android-app-id-here',
    messagingSenderId: 'your-sender-id-here',
    projectId: 'your-project-id-here',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key-here',
    appId: 'your-ios-app-id-here',
    messagingSenderId: 'your-sender-id-here',
    projectId: 'your-project-id-here',
    storageBucket: 'your-project-id.appspot.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your-ios-api-key-here',
    appId: 'your-ios-app-id-here',
    messagingSenderId: 'your-sender-id-here',
    projectId: 'your-project-id-here',
    storageBucket: 'your-project-id.appspot.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'your-web-api-key-here',
    appId: 'your-web-app-id-here',
    messagingSenderId: 'your-sender-id-here',
    projectId: 'your-project-id-here',
    authDomain: 'your-project-id.firebaseapp.com',
    storageBucket: 'your-project-id.appspot.com',
  );
}
