import 'package:flutter/material.dart';
import 'package:voz_popular/widgets/textfield_widget.dart';


class RegisterFormView extends StatefulWidget{
  const RegisterFormView({super.key});

  @override
  State<RegisterFormView> createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView> {
  bool open = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  "assets/images/voz_popular_logo_white.png",
                  width: 150,
                ),
              ),
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(300)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                              'https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcRoT6NNDUONDQmlthWrqIi_frTjsjQT4UZtsJsuxqxLiaFGNl5s3_pBIVxS6-VsFUP_',
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Nombre',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10)
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Actividad economica',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10)
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences  ,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    textAlign: TextAlign.justify,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        labelText: 'Cuentanos sobre tu negocio',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(10)
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Mercado',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                ),
              ),
              Text(
                open?'Negocio Abierto':'Negocio Cerrado',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              Switch(
                // This bool value toggles the switch.
                value: open,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    open = value;
                  });
                },
              )
            ],
          ),
        ),
      )
    );
  }
}