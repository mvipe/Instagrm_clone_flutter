import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screens.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyBOHql_ENBGxPUrYzNn8F8WMBlVy9hfxF8",
          appId: "1:928046563133:web:397a580941ca1515ba4f54",
          messagingSenderId: "928046563133",
          projectId: "instagram-clone-flutter-734e3",
          storageBucket:"instagram-clone-flutter-734e3.appspot.com"),

    );
  }else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,

      ),
      home: LoginScreen()
      //ResponsiveLayout(mobileScreenLayout: MobileScreenLayout() ,webScreenLayout: WebScreenLayout(),)
    );
  }
}


