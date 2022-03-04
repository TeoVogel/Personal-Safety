// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTjcs9SwGuRAs5m8TPBykuROcUuikcC4s',
    appId: '1:595577006629:android:156498ba6ffec7c5e32dcc',
    messagingSenderId: '595577006629',
    projectId: 'personal-safety-uottawa',
    storageBucket: 'personal-safety-uottawa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYkMXJw660xH8gmR7raFsIwIOmI5ZaHTs',
    appId: '1:595577006629:ios:eb564c81792c9c4ae32dcc',
    messagingSenderId: '595577006629',
    projectId: 'personal-safety-uottawa',
    storageBucket: 'personal-safety-uottawa.appspot.com',
    iosClientId:
        '595577006629-op95so4ofh4kt9tq7ndhqd8crnj5g32l.apps.googleusercontent.com',
    iosBundleId: 'gng2102.uottawa.personalSafety',
  );
}
