import "package:flutter/material.dart";

class ButtonWidget extends StatefulWidget{
  final double width;
  final double height;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Function? onTap;
  const ButtonWidget(
    {
      super.key,
      this.text = "Default Text",
      this.backgroundColor = Colors.white,
      this.textColor = Colors.black,
      this.width = 323,
      this.height = 50,
      this.onTap,
    }
  );

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Ink(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: (){
            if(widget.onTap != null){
              widget.onTap!();
            }
          },
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        )
      ),
    );
  }
}