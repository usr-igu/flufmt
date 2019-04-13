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
      theme: ThemeData.dark(),
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
  var _cardsListScrollController = ScrollController();
  @override
  void initState() {
    getIt.get<NoticiaBloc>().dispatch(LoadNoticias(pagina: 0, quantidade: 3));
    _cardsListScrollController.addListener(() {
      if (_cardsListScrollController.position.extentAfter <= 0) {
        getIt.get<NoticiaBloc>().dispatch(LoadNextPage());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _cardsListScrollController.dispose();
    getIt.get<NoticiaBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoticiaEvent, NoticiasState>(
        bloc: getIt.get<NoticiaBloc>(),
        builder: (context, state) {
          if (state is NoticiasLoaded) {
            return ListView.builder(
              controller: _cardsListScrollController,
              itemCount: state.noticias.length + 1,
              itemBuilder: (context, index) {
                if (index < state.noticias.length) {
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
                }
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ));
              },
            );
          } else if (state is NoticiasLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NoticiasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, color: Colors.red),
                ),
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
        errorWidget: (context, url, error) => Center(
              child: Text('Não foi possível carregar essa imagem.'),
            ),
        fit: BoxFit.cover,
      );
      return image;
    } catch (e) {
      return null;
    }
  }
}
