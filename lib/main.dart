import 'dart:convert';

import 'package:flufmt/noticia_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flufmt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'flufmt'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoticiaModel> lista;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<NoticiaModel>>(
        future: getNoticias(),
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                  child: NoticiaCard(
                    tituloNoticia: snapshot.data[index].tituloNoticia,
                    chamadaNoticia: snapshot.data[index].chamadaNoticia,
                    imagemNoticia: snapshot.data[index].imagemNoticia,
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<NoticiaModel>> getNoticias() async {
    List<NoticiaModel> lista = List();
    final response =
        await http.get('http://www.ufmt.br/webservice/teste.php/0/10');
    final map = jsonDecode(response.body);
    map.forEach((e) {
      lista.add(NoticiaModel.fromJson(e));
    });
    return lista;
  }
}

class NoticiaCard extends StatelessWidget {
  final String tituloNoticia;
  final String chamadaNoticia;
  final String imagemNoticia;

  String get _imagemUrl => imagemNoticia != null
      ? 'http://www.ufmt.br/ufmt/site/userfiles/noticias/$imagemNoticia'
      : null;

  const NoticiaCard({
    Key key,
    @required this.tituloNoticia,
    this.chamadaNoticia,
    this.imagemNoticia,
  })  : assert(tituloNoticia != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (imagemNoticia != null)
              ? Container(
                  constraints: BoxConstraints.expand(height: 200.0),
                  child: Image.network(
                    _imagemUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tituloNoticia,
                  style: TextStyle(fontSize: 22.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(chamadaNoticia)
              ],
            ),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('LER'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.share,
                        size: 16.0,
                      ),
                      const Text('COMPARTILHAR'),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ].where((o) => o != null).toList(),
      ),
    );
  }
}
