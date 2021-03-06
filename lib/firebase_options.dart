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
    apiKey: 'AIzaSyBFSkkJxn1hlKmg6iFXf2Ave8TgpUIMpVE',
    appId: '1:1023036926670:web:8f32ee686e621d79e9be9f',
    messagingSenderId: '1023036926670',
    projectId: 'fir-series-bfbe5',
    authDomain: 'fir-series-bfbe5.firebaseapp.com',
    storageBucket: 'fir-series-bfbe5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4wYWsZgA8UCz03izpmnFtUWvq07C6ZGY',
    appId: '1:1023036926670:android:7f64e0dcac92b710e9be9f',
    messagingSenderId: '1023036926670',
    projectId: 'fir-series-bfbe5',
    storageBucket: 'fir-series-bfbe5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBb1gury6Pgxq_7rJnyfWAoqri9IQe0wAU',
    appId: '1:1023036926670:ios:22f3e419d310f4b0e9be9f',
    messagingSenderId: '1023036926670',
    projectId: 'fir-series-bfbe5',
    storageBucket: 'fir-series-bfbe5.appspot.com',
    iosClientId: '1023036926670-364k43tch3381k7kfpeh62aoinqep4dd.apps.googleusercontent.com',
    iosBundleId: 'com.example.fires',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBb1gury6Pgxq_7rJnyfWAoqri9IQe0wAU',
    appId: '1:1023036926670:ios:22f3e419d310f4b0e9be9f',
    messagingSenderId: '1023036926670',
    projectId: 'fir-series-bfbe5',
    storageBucket: 'fir-series-bfbe5.appspot.com',
    iosClientId: '1023036926670-364k43tch3381k7kfpeh62aoinqep4dd.apps.googleusercontent.com',
    iosBundleId: 'com.example.fires',
  );
}
