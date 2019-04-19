import 'package:cached_network_image/cached_network_image.dart';
import 'package:flufmt/eventos/bloc/eventos.dart';
import 'package:flufmt/common.dart';
import 'package:flufmt/eventos/evento_model.dart';
import 'package:flufmt/eventos/pages/ler_evento_page.dart';
import 'package:flufmt/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventosPage extends StatefulWidget {
  EventosPage({Key key}) : super(key: key);

  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  var _cardsListScrollController = ScrollController();

  @override
  void initState() {
    _loadEventos();
    super.initState();
  }

  void _loadEventos() {
    getIt.get<EventosBloc>().dispatch(LoadEventos());
  }

  @override
  void dispose() {
    _cardsListScrollController.dispose();
    getIt.get<EventosBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EventosEvent, EventosState>(
        bloc: getIt.get<EventosBloc>(),
        builder: (context, state) {
          if (state is EventosLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                _loadEventos();
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _cardsListScrollController,
                itemCount: state.eventos.length,
                itemBuilder: (context, index) {
                  if (index < state.eventos.length) {
                    return GestureDetector(
                      onTap: () =>
                          _pushPaginaLerEvento(context, state.eventos[index]),
                      child: EventoCard(
                        evento: state.eventos[index],
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
          } else if (state is EventosLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EventosError) {
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
                _loadEventos();
              },
            );
          }
          return Container(width: 0.0, height: 0.0);
        },
      ),
    );
  }
}

class EventoCard extends StatelessWidget {
  final EventoModel evento;

  String get _imagemUrl => evento.iconeDivulgacao != null
      ? 'http://www.ufmt.br/ufmt/site/userfiles/divulgacao/${evento.iconeDivulgacao}'
      : null;

  const EventoCard({
    Key key,
    @required this.evento,
  })  : assert(evento != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    evento.tituloDivulgacao,
                    style: TextStyle(fontSize: 21.0),
                  ),
                ],
              ),
            ),
            trailing: SizedBox(
                width: 64,
                height: 64,
                child: (_imagemUrl != null) ? _buildImage(_imagemUrl) : null),
          ),
          // FIXME: No futuro usar os temas globais aqui.
          ButtonTheme.bar(
            layoutBehavior: ButtonBarLayoutBehavior.constrained,
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  textColor: CustomColors.AZUL_UFMT,
                  child: const Text('DETALHES'),
                  onPressed: () {
                    _pushPaginaLerEvento(context, evento);
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
                  onPressed: () => compartilhaEvento(
                        titulo: evento.tituloDivulgacao,
                        idEvento: evento.idDivulgacao,
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
        fit: BoxFit.cover,
      );
      return image;
    } catch (e) {
      return null;
    }
  }
}

void _pushPaginaLerEvento(BuildContext context, EventoModel evento) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LerEventoPage(evento: evento),
    ),
  );
}
