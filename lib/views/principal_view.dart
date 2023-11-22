import 'dart:collection';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voz_popular/views/chat_view.dart';
import 'package:voz_popular/views/login_view.dart';
import 'package:voz_popular/views/map_view.dart';
import 'package:voz_popular/views/profile_list_view.dart';
import 'package:voz_popular/views/profile_view.dart';
import 'package:voz_popular/views/register_form_view.dart';
import 'package:voz_popular/widgets/button_widget.dart';

import '../services/firebase_service.dart';

class PrincipalView extends StatefulWidget{
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {

  int pageIndex = 2;

  final pages = [
    const RegisterFormView(),
    const ChatView(),
    const ProfileListView(),
  ];

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

      backgroundColor: const Color(0xFF2697b4),
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuration'
          ),
        ],
      ),
    );
  }
}