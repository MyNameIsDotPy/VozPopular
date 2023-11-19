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
        decoration: const BoxDecoration(
          color: Color(0xFF04364A),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            message,
            style: const TextStyle(
              color: Color(0xFFDAFFFB)
            ),
          ),
        )
      ),
    );
  }
}