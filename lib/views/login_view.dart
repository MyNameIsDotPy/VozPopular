import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voz_popular/services/firebase_service.dart';
import 'package:voz_popular/widgets/button_widget.dart';
import 'package:voz_popular/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';


class LogInView extends StatefulWidget{
  const LogInView({super.key});


  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    final FirebaseService firebaseService = Provider.of<FirebaseService>(context);

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/voz_popular_logo.png",
                          width: 190,
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
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Usuario',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF04364A)
                            ),
                          ),
                          TextFieldWidget(
                            textEditingController: userController,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contraseña',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF04364A),
                            ),
                          ),
                          TextFieldWidget(
                            prefixIcon: !obscureText?Icons.visibility:Icons.visibility_off,
                            obscureText: obscureText,
                            onPrefixAction: (){
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            textEditingController: passwordController,
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonWidget(
                            text: "Iniciar Sesión",
                            backgroundColor: const Color(0xFF04364A),
                            textColor: Colors.white,
                            height: 69,
                            onTap: () async {
                              String user = userController.text;
                              String password = passwordController.text;
                              try{
                                await firebaseService.signInWithEmailAndPassword(user, password);
                                print(password);
                                print(user);
                                print(FirebaseAuth.instance.currentUser);
                              }
                              on Exception catch(e){
                                if(context.mounted){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString()))
                                  );
                                }
                              }

                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'O crea una cuenta',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xA0FFFFFF),
                          ),
                          child: Image.asset(
                            "assets/images/google_logo.png",
                            width: 100,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}