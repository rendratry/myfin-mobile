git commit -m "first commit"
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfin_app/homepage/navbar.dart';
import 'package:myfin_app/loginpage/login_screen.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await firebase_core.Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences server = await SharedPreferences.getInstance();
  await server.setString('server', "192.168.79.47:3000");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Myfin App",
      initialRoute: 'loginscreen',
    routes: {
      // When navigating to the "homeScreen" route, build the HomeScreen widget.
      'loginscreen': (context) => LoginDemo(),
      // When navigating to the "secondScreen" route, build the SecondScreen widget.
      'navbar': (context) => const Navbar(),
    },
    );
  }
}
