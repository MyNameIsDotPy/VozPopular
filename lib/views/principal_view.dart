import 'dart:collection';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voz_popular/views/chat_view.dart';
import 'package:voz_popular/views/map_view.dart';
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

    /*
    Stream<OpenAIStreamChatCompletionModel> chatStream = OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: [
        const OpenAIChatCompletionChoiceMessageModel(
          content: "hello",
          role: OpenAIChatMessageRole.user,
        )
      ],
    );

    chatStream.listen((streamChatCompletion) {
      final content = streamChatCompletion.choices.first.delta.content;
      print(content);
    });
    */

    return Scaffold(
      backgroundColor: const Color(0xFF176B87),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                //color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/voz_popular_logo_white.png",
                      width: 120,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 394/498,
                        child: Container(
                          height: 300,
                          decoration: const BoxDecoration(
                            color: Color(0xA0FFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: const Center(
                            child: Text(
                              "Consejo del día / Publicidad",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF04364A)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: const Color(0xFF04364A),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const MapSample()));
                          },
                          icon: const Icon(Icons.map, color: Color(0xFFDAFFFB))
                      ),
                      const SizedBox(),
                      IconButton(onPressed: (){firebaseService.signOut();}, icon: const Icon(Icons.exit_to_app, color: Color(0xFFDAFFFB))),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: -40,
                  child: Center(
                    child: Ink(
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF04364A),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF176B87),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset(0, 2)
                              )
                            ]
                          ),
                          width: 80,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                "assets/images/mic_white.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                )
              ],
            )
          ],
        ),
      )
    );
  }
}