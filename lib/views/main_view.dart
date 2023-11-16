import "package:flutter/material.dart";
import "package:voz_popular/views/auth_gate_view.dart";
import "package:voz_popular/views/login_view.dart";
import "package:voz_popular/widgets/button_widget.dart";

class MainView extends StatelessWidget{
  const MainView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFDAFFFB),
                  Color(0xFF04364A)
                ]
            )
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  "assets/images/voz_popular_logo.png",
                  width: 250,
                ),
              ),
              const Column(
                children: [
                  Text(
                    "Tu empresa, tu voz",
                    style: TextStyle(
                        color: Color(0xFF04364A),
                        fontWeight: FontWeight.bold,
                        fontSize: 27
                    ),
                  ),
                  Text(
                    "Dale voz a tu negocio",
                    style: TextStyle(
                        color: Color(0xFF04364A),
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ],
              ),
              ButtonWidget(
                text: "Iniciar Sesión",
                backgroundColor: const Color(0xA004364A),
                textColor: const Color(0xFFDAFFFB),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const AuthGateView())
                  );
                },
              ),
              ButtonWidget(
                text: "Registro",
                backgroundColor: const Color(0xA0DAFFFB),
                textColor: const Color(0xFF04364A),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const AuthGateView())
                  );
                },
              )
            ],
          ),
        ),
      )
    );
  }
}