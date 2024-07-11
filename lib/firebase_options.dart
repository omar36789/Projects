import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCUL8OcdRGojkgbO2IHyCeaY9XPP8Ps878',
    authDomain: 'capstone-f30d9.firebaseapp.com',
    projectId: 'capstone-f30d9',
    storageBucket: 'capstone-f30d9.appspot.com',
    messagingSenderId: '382739390482',
    appId: '1:382739390482:web:6f3b000a61753b3ac0f8cb',
    measurementId:
        'G-XXXXXXXXXX', // Replace 'XXXXXXXXXX' with your measurement ID if available.
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUL8OcdRGojkgbO2IHyCeaY9XPP8Ps878',
    authDomain: 'capstone-f30d9.firebaseapp.com',
    projectId: 'capstone-f30d9',
    storageBucket: 'capstone-f30d9.appspot.com',
    messagingSenderId: '382739390482',
    appId: '1:382739390482:android:6f3b000a61753b3ac0f8cb',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUL8OcdRGojkgbO2IHyCeaY9XPP8Ps878',
    authDomain: 'capstone-f30d9.firebaseapp.com',
    projectId: 'capstone-f30d9',
    storageBucket: 'capstone-f30d9.appspot.com',
    messagingSenderId: '382739390482',
    appId: 'your-ios-app-id', // Replace with your iOS app ID.
    iosBundleId: 'your-ios-bundle-id', // Replace with your iOS bundle ID.
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUL8OcdRGojkgbO2IHyCeaY9XPP8Ps878',
    authDomain: 'capstone-f30d9.firebaseapp.com',
    projectId: 'capstone-f30d9',
    storageBucket: 'capstone-f30d9.appspot.com',
    messagingSenderId: '382739390482',
    appId: 'your-macos-app-id', // Replace with your macOS app ID.
    iosBundleId: 'your-macos-bundle-id', // Replace with your macOS bundle ID.
  );
}
