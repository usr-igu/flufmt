import 'package:cached_network_image/cached_network_image.dart';
import 'package:flufmt/noticia/bloc/noticia.dart';
import 'package:flufmt/common.dart';
import 'package:flufmt/noticia/pages/ler_noticia_page.dart';
import 'package:flufmt/noticia/noticia_model.dart';
import 'package:flufmt/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoticiasPage extends StatefulWidget {
  NoticiasPage({Key key}) : super(key: key);

  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  var _cardsListScrollController = ScrollController();

  @override
  void initState() {
    _loadNoticias();
    _cardsListScrollController.addListener(() {
      if (_cardsListScrollController.position.extentAfter <= 0) {
        _loadNextPage();
      }
    });
    super.initState();
  }

  void _loadNoticias() {
    getIt.get<NoticiaBloc>().dispatch(LoadNoticias(pagina: 0));
  }

  void _loadNextPage() {
    getIt.get<NoticiaBloc>().dispatch(LoadNextPage());
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
            return RefreshIndicator(
              onRefresh: () async {
                _loadNoticias();
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _cardsListScrollController,
                itemCount: state.noticias.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.noticias.length) {
                    return GestureDetector(
                      onTap: () =>
                          _pushPaginaLerNoticia(context, state.noticias[index]),
                      child: NoticiaCard(
                        noticia: state.noticias[index],
                      ),
                    );
                  }
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ));
                },
              ),
            );
          } else if (state is NoticiasLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NoticiasError) {
            return RefreshIndicator(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0, color: Colors.red),
                    ),
                  ],
                ),
              ),
              onRefresh: () async {
                _loadNoticias();
              },
            );
          }
          return Container(width: 0.0, height: 0.0);
        },
      ),
    );
  }
}

class NoticiaCard extends StatelessWidget {
  final NoticiaModel noticia;

  String get _imagemUrl => noticia.imagemNoticia != null
      ? 'http://www.ufmt.br/ufmt/site/userfiles/noticias/${noticia.imagemNoticia}'
      : null;

  const NoticiaCard({
    Key key,
    @required this.noticia,
  })  : assert(noticia != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (_imagemUrl != null)
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
                  noticia.tituloNoticia,
                  style: TextStyle(fontSize: 22.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(noticia.chamadaNoticia)
              ],
            ),
          ),
          // FIXME: No futuro usar os temas globais aqui.
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  textColor: CustomColors.AZUL_UFMT,
                  child: const Text('LER'),
                  onPressed: () {
                    _pushPaginaLerNoticia(context, noticia);
                  },
                ),
                FlatButton(
                  textColor: CustomColors.AZUL_UFMT,
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.share,
                        size: 16.0,
                      ),
                      const Text(
                        'COMPARTILHAR',
                      ),
                    ],
                  ),
                  onPressed: () => compartilhaNoticia(
                        titulo: noticia.tituloNoticia,
                        idNoticia: noticia.idNoticia,
                      ),
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
              child: Text(
                'Não foi possível carregar essa imagem.',
              ),
            ),
        fit: BoxFit.scaleDown,
      );
      return image;
    } catch (e) {
      return null;
    }
  }
}

void _pushPaginaLerNoticia(BuildContext context, NoticiaModel noticia) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LerNoticiaPage(noticia: noticia),
    ),
  );
}
