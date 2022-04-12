import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'responsive/mobile_screen_layout.dart';
import 'responsive/respsonsive_screen_layout.dart';
import 'responsive/web_screen_layout.dart';
import 'screens/login_screen.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD2ZJoRLLXrCjDtw1I0Dh93VsaDXVIpAJ0',
        appId: '1:455073831605:web:2f8f7b4f560e3fc4fcbcfc',
        messagingSenderId: '455073831605',
        projectId: 'instagram-clone-848bb',
        storageBucket: 'instagram-clone-848bb.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: LoginScreen(),
    );
  }
}
