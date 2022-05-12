import 'package:flutter/material.dart';
import 'package:flutter_ornek32/main.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

enum Cinsiyet {
  kadin,
  erkek,
  bos,
}

const okullar = ["ilkokul", "Ortaokul", "Lise", "Üniversite"];

class _InputPageState extends State<InputPage> {
  bool? okuldaMisin = false;
  Cinsiyet? cinsiyet = Cinsiyet.bos;
  String? okul;
  double boy = 100;
  TextEditingController yorumController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    yorumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Girdi Sayfası"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: const Color(0xffeeee00),
                          height:120.0,
                          alignment:Alignment.center,
                          child: const Text("Fixed Height Content"),
                        ),
                        Expanded(
                          child: Container(
                            color: const Color(0xffee0000),
                            height: 120.0,
                            alignment: Alignment.center,
                            child: const Text(
                              "Flexible Content"
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Checkbox(
                        value: okuldaMisin,
                        onChanged: (value) {
                          setState(() {
                            okuldaMisin = value;
                          });
                        }),
                      Switch(
                        value: okuldaMisin!,
                        onChanged: (value) {
                          setState(() {
                            okuldaMisin = value;
                          });
                        }),
                      Text(
                        // null olmaktan kurtulmak için
                        okuldaMisin == true ? "Okuldasın" : "Okuda değilsin",
                      ),
                    Radio<Cinsiyet>(
                      value: Cinsiyet.kadin,
                      groupValue: cinsiyet,
                      onChanged: (value) {
                        setState(() {
                          cinsiyet = value;
                        });
                      },
                    ),
                    Radio<Cinsiyet>(
                      value: Cinsiyet.erkek,
                      groupValue: cinsiyet,
                      onChanged: (value) {
                        setState(() {
                          cinsiyet = value;
                        });
                      },
                    ),
                    Text(cinsiyet.toString()),
                    DropdownButtonFormField<String>(
                      value: okul,
                      items: okullar
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          okul = value;
                        });
                      },
                      validator: (value){
                        if (!okullar.contains(value)){
                          return "Lütfen okul seçin.";
                        }
                      },
                      onSaved: (newValue){
                        print("Okul kaydedildi. $newValue");
                      },
                    ),
                    Text(okul ?? ""),
                    Slider(
                      value: boy,
                      min: 30,
                      max: 300,
                      onChanged: (double value) {
                        setState(() {
                          boy = value;
                        });
                      },
                    ),
                    Text(
                      boy.toStringAsFixed(2), // noktadan sonra iki basamak koy
                    ),
                    TextFormField(
                      controller: yorumController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value){
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Boş bırakılamaz ...";
                          } else {
                              return null;
                            }
                          } else {
                              return "null olamaz !!!";
                        }
                      },
                      onSaved: (newValue){
                        print("YORUM Kaydediliyor ... $newValue");
                      },
                    ),
                    Text(yorumController.text),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            okuldaMisin = false;
                            cinsiyet = Cinsiyet.bos;
                            okul = null;
                            boy = 100;
                            yorumController.text = "";
                          });
                        },
                        child: const Text("Temizle")),
                    ElevatedButton(
                      onPressed: () {
                        print("gönder");
                        final icerikUygunMu = formKey.currentState?.validate();
                        if (icerikUygunMu == true) {
                          formKey.currentState?.save();
                        }
                      },
                        child: const Text("Gönder"))
                    ],
                  ),
                ),
              ],
            ),
          );
        }
       ),
      );
  }
}
