import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:voz_popular/services/firebase_service.dart';
import 'package:voz_popular/views/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //SystemUiOverlay.bottom,
    SystemUiOverlay.top
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
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
      ],
      child: MaterialApp(
        title: 'Voz Popular',
        debugShowCheckedModeBanner: false,
        //debugShowMaterialGrid: true,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'GlacialIndifference',
          inputDecorationTheme: const InputDecorationTheme(

          )
        ),

        home: MainView(),
      ),
    );
  }
}


