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
    apiKey: 'AIzaSyCfzIXEriZWePaAzzuap8LHA0nE1W2Lsyg',
    appId: '1:552632741380:web:3f2825d6ad91f597c18f51',
    messagingSenderId: '552632741380',
    projectId: 'tod-apps-6cdb8',
    authDomain: 'tod-apps-6cdb8.firebaseapp.com',
    storageBucket: 'tod-apps-6cdb8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM39jFNswTJSXAXYv6ukeTu0T0WgMB2Eg',
    appId: '1:552632741380:android:c5a15a5f2e359213c18f51',
    messagingSenderId: '552632741380',
    projectId: 'tod-apps-6cdb8',
    storageBucket: 'tod-apps-6cdb8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwHMnzZngLbcmlO6_puWbxsy2Y-C1HV8I',
    appId: '1:552632741380:ios:44b9991049183e9fc18f51',
    messagingSenderId: '552632741380',
    projectId: 'tod-apps-6cdb8',
    storageBucket: 'tod-apps-6cdb8.appspot.com',
    iosBundleId: 'com.todoapps.todoapps',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwHMnzZngLbcmlO6_puWbxsy2Y-C1HV8I',
    appId: '1:552632741380:ios:44b9991049183e9fc18f51',
    messagingSenderId: '552632741380',
    projectId: 'tod-apps-6cdb8',
    storageBucket: 'tod-apps-6cdb8.appspot.com',
    iosBundleId: 'com.todoapps.todoapps',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCfzIXEriZWePaAzzuap8LHA0nE1W2Lsyg',
    appId: '1:552632741380:web:972698c475b6c471c18f51',
    messagingSenderId: '552632741380',
    projectId: 'tod-apps-6cdb8',
    authDomain: 'tod-apps-6cdb8.firebaseapp.com',
    storageBucket: 'tod-apps-6cdb8.appspot.com',
  );
}
