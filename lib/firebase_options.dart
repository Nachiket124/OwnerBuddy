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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0LGZ2IuQnlC7EBQ-JO8SwZEz06Tu7HxU',
    appId: '1:989329886895:android:21da1dc454f2d77a550e5a',
    messagingSenderId: '989329886895',
    projectId: 'ownerbuddy-ca266',
    storageBucket: 'ownerbuddy-ca266.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0lE_zFAsKmVCf-Q4RHdR07RkfL0m7CZE',
    appId: '1:989329886895:ios:6b22749a9c85fd23550e5a',
    messagingSenderId: '989329886895',
    projectId: 'ownerbuddy-ca266',
    storageBucket: 'ownerbuddy-ca266.appspot.com',
    iosClientId: '989329886895-17jdkfu9qno4vf7ovqi97ig0sdnqnr02.apps.googleusercontent.com',
    iosBundleId: 'com.ownnerBuddy1.app',
  );
}
