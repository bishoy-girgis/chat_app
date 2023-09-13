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
    apiKey: 'AIzaSyCRGt5c0w_r98DZ5M-jVsa90DOi10unmF4',
    appId: '1:449477318746:web:b746dc03e342d269232063',
    messagingSenderId: '449477318746',
    projectId: 'chat-app-becdc',
    authDomain: 'chat-app-becdc.firebaseapp.com',
    storageBucket: 'chat-app-becdc.appspot.com',
    measurementId: 'G-Y2JL6W990W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCephJwHW2oFd1zeCTAB_0UPC6vvA5IGJ8',
    appId: '1:449477318746:android:249fec5b9e41ef5a232063',
    messagingSenderId: '449477318746',
    projectId: 'chat-app-becdc',
    storageBucket: 'chat-app-becdc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMcEQmVfRX31q4FJChyLZd1cFGyUPO8qU',
    appId: '1:449477318746:ios:bc9006de665091c9232063',
    messagingSenderId: '449477318746',
    projectId: 'chat-app-becdc',
    storageBucket: 'chat-app-becdc.appspot.com',
    iosClientId: '449477318746-2ila850fls943dqkeakip2jhss8fs1ic.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMcEQmVfRX31q4FJChyLZd1cFGyUPO8qU',
    appId: '1:449477318746:ios:bc9006de665091c9232063',
    messagingSenderId: '449477318746',
    projectId: 'chat-app-becdc',
    storageBucket: 'chat-app-becdc.appspot.com',
    iosClientId: '449477318746-2ila850fls943dqkeakip2jhss8fs1ic.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
