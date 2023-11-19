import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:voz_popular/widgets/message_widget.dart';
import 'package:voz_popular/widgets/textfield_widget.dart';

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

  @override
  void initState() {

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
        model: 'gpt-3.5-turbo',
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
                padding: const EdgeInsets.all(20),
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
                                if(!disable){
                                  String chatText = chatController.text;
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
                                      model: 'gpt-3.5-turbo',
                                      messages: promptsList,
                                      maxTokens: 100,
                                      toolChoice: "auto",
                                      tools: openAIFunctions
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
                              },
                              icon: !disable?const Icon(Icons.send):const CircularProgressIndicator()
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