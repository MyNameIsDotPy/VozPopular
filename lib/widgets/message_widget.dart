import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget{
  const MessageWidget({super.key, required this.message, required this.role});
  final String message;
  final OpenAIChatMessageRole role;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: role==OpenAIChatMessageRole.user?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: role==OpenAIChatMessageRole.user?const Color(0xFF04364A):
          const Color(0xFF176B87),
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            message,
            style: TextStyle(
              color: role==OpenAIChatMessageRole.user?const Color(0xFFDAFFFB):const Color(0xFFDAFFFB)
            ),
          ),
        )
      ),
    );
  }
}