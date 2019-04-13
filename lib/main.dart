import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            child: NoticiaCard(
              tituloNoticia: 'SISU 2019 - Quarta Convocatória para Matrícula (16 e 17\/04\/2019)',
              chamadaNoticia: 'SISU 2019 - Quarta Convocatória para Matrícula (dias 16 e 17)',
              imagemNoticia: 'd05b551cccbdb8c3ff7d32e2db44ea10.png',
            ),
          );
        },
      ),
    );
  }
}

class NoticiaCard extends StatelessWidget {
  final String tituloNoticia;
  final String chamadaNoticia;
  final String imagemNoticia;
  String get _imagemUrl => imagemNoticia != null ? 'http://www.ufmt.br/ufmt/site/userfiles/noticias/$imagemNoticia' : null;

  const NoticiaCard({
    Key key,
    @required this.tituloNoticia,
    this.chamadaNoticia,
    this.imagemNoticia,
  }) : assert(tituloNoticia != null), super(key: key);

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
