import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voz_popular/widgets/button_widget.dart';

import '../services/firebase_service.dart';

class PrincipalView extends StatefulWidget{
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  @override
  Widget build(BuildContext context) {

    final FirebaseService firebaseService  = Provider.of<FirebaseService>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text(
                  "Usuario loggeado"
              )
          ),

          ButtonWidget(
            text: "Cerrar Sesión",
            onTap: (){
              firebaseService.signOut();
            },
          )
        ],
      )
    );
  }
}