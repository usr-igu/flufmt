import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flufmt/bloc_delegate.dart';
import 'package:flufmt/noticia/bloc/noticia.dart';
import 'package:flufmt/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flufmt',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF1C262A),
        accentColor: Color(0xFFA7D9D5),
        buttonColor: Color(0xFF1C262A),
        disabledColor: Colors.white12,
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
  void initState() {
    getIt.get<NoticiaBloc>().dispatch(LoadNoticias(quantidade: 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoticiaEvent, NoticiaState>(
        bloc: getIt.get<NoticiaBloc>(),
        builder: (context, state) {
          if (state is NoticiaLoaded) {
            return ListView.builder(
              itemCount: state.noticias.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 4.0,
                    right: 4.0,
                    bottom: 4.0,
                  ),
                  child: NoticiaCard(
                    tituloNoticia: state.noticias[index].tituloNoticia,
                    chamadaNoticia: state.noticias[index].chamadaNoticia,
                    imagemNoticia: state.noticias[index].imagemNoticia,
                  ),
                );
              },
            );
          } else if (state is NoticiaLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NoticiaError) {
            return Center(
              child: Text(
                state.error,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.red),
              ),
            );
          }
          return Container(
            width: 0.0,
            height: 0.0,
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
            constraints: BoxConstraints.tightFor(
              width: double.infinity,
              height: 200.0,
                  ),
            child: _buildImage(_imagemUrl),
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

  Widget _buildImage(String url) {
    try {
      final image = CachedNetworkImage(
        imageUrl: url,
        errorWidget: (context, url, error) =>
            Center(
              child: Text('Nao foi possivel carregar essa imagem.'),
            ),
        fit: BoxFit.cover,
      );
      return image;
    } catch (e) {
      return null;
    }
  }
}
