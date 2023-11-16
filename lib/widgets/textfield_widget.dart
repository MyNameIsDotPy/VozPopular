import "package:flutter/material.dart";

class TextFieldWidget extends StatefulWidget{
  final VoidCallback? onPrefixAction;
  final IconData? prefixIcon;
  final TextEditingController? textEditingController;
  final bool obscureText;
  const TextFieldWidget({super.key, this.prefixIcon, this.textEditingController, this.onPrefixAction, this.obscureText = false});


  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 323,
      child: TextField(
        controller: widget.textEditingController??widget.textEditingController,
        cursorColor: const Color(0xFF04364A),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: Color(0xFF04364A),
                  strokeAlign: BorderSide.strokeAlignCenter,
                  width: 3
              )
          ),
          suffixIcon: widget.prefixIcon!=null?IconButton(icon: Icon(widget.prefixIcon!), onPressed: widget.onPrefixAction ?? (){},):null,

          fillColor: const Color(0xA0FFFFFF),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),

        ),
      )
    );
  }
}