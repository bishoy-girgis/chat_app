import 'package:chat_app/consts/my_theme.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/ui/addRoom/add_room_screen.dart';
import 'package:chat_app/ui/chat/chat_thread.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/registeration/register_screen.dart';
import 'package:chat_app/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat app',
      theme: MyTheme.lightTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
        AddRoomScreen.routeName:(context) => AddRoomScreen(),
        ChatThread.routeName:(context) => ChatThread(),

      },
    );
  }
}
