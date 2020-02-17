import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:async";
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=1736048a";

void main() async {
  print(await getData());
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
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

class _HomeState extends State<Home> {
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Conversor de moedas"),
          backgroundColor: Colors.amber,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text(
                      "Carregando dados...",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erro ao carregando dados!",
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                            size: 100.0,
                            color: Colors.amber,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                              top: 40,
                              right: 16,
                              bottom: 20,
                            ),
                            child: TextField(
                            decoration: InputDecoration(
                              labelText: "Reais",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "R\$",
                            ),
                            style: TextStyle(
                              color: Colors.amber, fontSize: 20.0),
                            )
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 20,
                            ),
                            child: TextField(
                            decoration: InputDecoration(
                              labelText: "Doláres",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "US\$",
                            ),
                            style: TextStyle(
                              color: Colors.amber, fontSize: 20.0),
                            )
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 20,
                            ),
                            child: TextField(
                            decoration: InputDecoration(
                              labelText: "Euros",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "€",
                            ),
                            style: TextStyle(
                              color: Colors.amber, fontSize: 20.0),
                            )
                          )
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
