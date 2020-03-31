import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=64aa9366";

void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// theme: ThemeData(
//       hintColor: Colors.amber,
//       primaryColor: Colors.white,
//       inputDecorationTheme: InputDecorationTheme(
//         enabledBorder:
//             OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//         focusedBorder:
//             OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
//         hintStyle: TextStyle(color: Colors.amber),
//       )),
// ));

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          "\$ Conversor \$",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados :(",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  ),
                );
              }else{
                return Container(color:Colors.green);
              }

          }
        },
      ),
    );
  }
}
