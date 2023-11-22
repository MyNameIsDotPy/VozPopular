import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:voz_popular/services/firebase_service.dart';
import 'package:voz_popular/services/map_service.dart';
import 'package:voz_popular/views/chat_view.dart';
import 'package:voz_popular/views/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:voz_popular/views/map_view.dart';
import 'env/env.dart';
import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  OpenAI.apiKey = Env.apiKey;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //SystemUiOverlay.bottom,
    SystemUiOverlay.top
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>FirebaseService()),
        ChangeNotifierProvider(create: (context)=>MapService()),
      ],
      child: MaterialApp(
        title: 'Voz Popular',
        debugShowCheckedModeBanner: false,
        //debugShowMaterialGrid: true,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'GlacialIndifference',
          inputDecorationTheme: const InputDecorationTheme(),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF04364A),
            showUnselectedLabels: false,
            unselectedItemColor: Color(0xFF64CCC5),
            selectedItemColor: Color(0xFFDAFFFB)
          )
        ),
        home: const MainView(),
      ),
    );
  }
}


