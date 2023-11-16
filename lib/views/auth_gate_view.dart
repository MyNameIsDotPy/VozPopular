import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voz_popular/services/firebase_service.dart';
import 'package:voz_popular/views/login_view.dart';
import 'package:voz_popular/views/principal_view.dart';

class AuthGateView extends StatefulWidget{
  const AuthGateView({super.key});


  @override
  State<AuthGateView> createState() => _AuthGateViewState();
}

class _AuthGateViewState extends State<AuthGateView> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const PrincipalView();
        }
        return const LogInView();
      }
    );
  }
}