import 'dart:io';

import 'package:assemblyai_flutter_sdk/assemblyai_flutter_sdk.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voz_popular/widgets/message_widget.dart';
import 'package:voz_popular/widgets/textfield_widget.dart';

import '../env/env.dart';
import '../openai_functions.dart';
import '../widgets/button_widget.dart';

class ChatView extends StatefulWidget{
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  final TextEditingController chatController = TextEditingController();
  List<OpenAIChatCompletionChoiceMessageModel> promptsList = [];
  bool disable = false;
  bool recording = false;
  final recorder = FlutterSoundRecorder();
  final api = AssemblyAI(Env.assemblyApiKey);
  Widget sendIconState = const Icon(Icons.record_voice_over);

  Future record() async{
    await recorder.startRecorder(toFile: 'audio.mp4');
  }
  Future<String> stop() async{
    final path = await recorder.stopRecorder();
    print(path);
    return path!;
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw 'Microfono denegado';
    }
    await recorder.openRecorder();
  }

  @override
  void initState() {
    initRecorder();
    setState(() {
      var initialMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            'Tu nombre es vix, una IA experta en administración de negocios.'
            'Tu principal objetivo es ayudar y dar consejos para mejorar el negocio de tu nuevo usuario.'
            'Asegurate de tener toda la informacion. Si tu usuario no responde todas tus preguntas, puedes volver a preguntarle hasta que tengas toda la información que necesitas.'
            'Presentate.'
            'Despues de que el usuario te de toda la información, repitela para confirmar, solo cuando te la de toda.'
            'Se amable y pregunta todo lo que necesites, presenta las preguntas en formato de lista.',
          )
        ],
        role: OpenAIChatMessageRole.system,
      );
      promptsList.add(initialMessage);
      disable = true;
    });

    OpenAI.instance.chat.create(
        //model: 'gpt-3.5-turbo',
        model: 'gpt-4',
        messages: promptsList
    ).then(
      (answer){
        promptsList.add(answer.choices[0].message);
        setState(() {
          disable = false;
        });
      }
    );

  }

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
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x00FFFFFF),
                              Color(0xA0FFFFFF)
                            ]
                          )
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          child: ListView.builder(

                              itemCount: promptsList.length,
                              itemBuilder: (context, index){

                                final message = promptsList[index];
                                if(message.role != OpenAIChatMessageRole.system) {

                                  String text = '';
                                  if(message.content != null){
                                    if(message.content!.first.text != null){
                                      text = message.content!.first.text!;
                                    }
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MessageWidget(
                                      message: text,
                                      role: message.role,
                                    ),
                                  );
                                }
                                return const SizedBox();
                              }
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: chatController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          suffixIcon: IconButton(
                              onPressed: () async {

                                String chatText = chatController.text;

                                if(!disable && chatText != ''){
                                  chatController.clear();
                                  setState(() {
                                    disable = true;
                                    promptsList.add(
                                      OpenAIChatCompletionChoiceMessageModel(
                                        content: [
                                          OpenAIChatCompletionChoiceMessageContentItemModel.text(
                                            chatText
                                          ),
                                        ],
                                        role: OpenAIChatMessageRole.user,
                                      )
                                    );
                                  });
                                  OpenAI.instance.chat.create(
                                    //model: 'gpt-3.5-turbo',
                                    model: 'gpt-4',
                                    messages: promptsList,
                                    //maxTokens: 100,
                                    // toolChoice: "auto",
                                    // tools: openAIFunctions
                                  ).then(
                                    (answer){
                                      setState(() {
                                        final message = answer.choices.first.message;
                                        promptsList.add(message);
                                        if(message.hasToolCalls){
                                          for(var call in message.toolCalls!){
                                            print(call.function.name);
                                            print(call.function.arguments);
                                          }
                                        }
                                        disable = false;
                                      });
                                    }
                                  );
                                }
                                else if(!disable && chatText == ''){
                                  if(recording){
                                    setState(() {
                                      recording = false;
                                    });
                                    final path = await stop();

                                    OpenAIAudioModel translation = await OpenAI.instance.audio.createTranslation(
                                      file: File(path),
                                      model: "whisper-1",
                                      prompt: 'Translate the audio to spanish.',
                                      responseFormat: OpenAIAudioResponseFormat.text,

                                    );

                                    setState(() {
                                      disable = true;
                                      promptsList.add(
                                          OpenAIChatCompletionChoiceMessageModel(
                                            content: [
                                              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                                                translation.text
                                              ),
                                            ],
                                            role: OpenAIChatMessageRole.user,
                                          )
                                      );
                                    });
                                    OpenAI.instance.chat.create(
                                      //model: 'gpt-3.5-turbo',
                                      model: 'gpt-4',
                                      messages: promptsList,
                                      //maxTokens: 100,
                                      // toolChoice: "auto",
                                      // tools: openAIFunctions
                                    ).then(
                                      (answer){
                                        setState(() {
                                          final message = answer.choices.first.message;
                                          promptsList.add(message);
                                          if(message.hasToolCalls){
                                            for(var call in message.toolCalls!){
                                              print(call.function.name);
                                              print(call.function.arguments);
                                            }
                                          }
                                          disable = false;
                                        });
                                      }
                                    );
                                  }
                                  else{
                                    record();
                                    setState(() {
                                      recording = true;
                                    });

                                    List<OpenAIModelModel> models = await OpenAI.instance.model.list();
                                    for(var i in models){
                                      print(i.id); // ...
                                      print(i.permission);
                                    }

                                  }
                                }
                              },
                              icon: !disable?sendIconState:const CircularProgressIndicator()
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide.none
                          ),
                          fillColor: const Color(0xA0FFFFFF),
                          filled: true
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}