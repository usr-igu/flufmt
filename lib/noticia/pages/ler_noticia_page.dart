import 'package:flufmt/noticia/noticia_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flufmt/common.dart';

class LerNoticiaPage extends StatelessWidget {
  final NoticiaModel noticia;

  const LerNoticiaPage({Key key, @required this.noticia})
      : assert(noticia != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${noticia.descricaoCategoria} - ${noticia.descricaoCampus}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: () => compartilhaNoticia(
              titulo: noticia.tituloNoticia,
              idNoticia: noticia.idNoticia,
            ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                noticia.tituloNoticia,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: CustomColors.AZUL_UFMT),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '${_converteDataHora(noticia.dataHoraNoticia)}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: -12.0,
                children: _buildAssuntoNoticiaChips(noticia.assuntoNoticia),
              ),
              Divider(),
              Html(
                data: noticia.textoNoticia,
                renderNewlines: true,
                useRichText: true,
                linkStyle: TextStyle(
                  color: CustomColors.AZUL_UFMT,
                ),
                onLinkTap: disparaUrl,
              ),
              SizedBox(
                height: 64.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  String _converteDataHora(String data) {
    try {
      final date = DateTime.parse(data);
      final elapsed = DateTime.now().difference(date);
      if (elapsed.inDays < 1) {
        if (elapsed.inHours < 1) {
          return 'há aproximadamente ${elapsed.inMinutes} minutos atrás';
        }
        return 'há aproximadamente ${elapsed.inHours} horas atrás';
      }
      return DateFormat.MMMMEEEEd().add_Hm().format(date);
    } catch (e) {
      return '';
    }
  }

  List<Widget> _buildAssuntoNoticiaChips(String assuntoNoticia) {
    if (assuntoNoticia == null || assuntoNoticia.isEmpty) {
      return List();
    }
    final assuntos = assuntoNoticia.split(';');
    return assuntos
        .map(
          (assunto) => Chip(
                avatar: Icon(
                  Icons.label,
                  color: Colors.grey[600],
                  size: 20.0,
                ),
                backgroundColor: Colors.grey[200],
                label: Text(assunto),
              ),
        )
        .toList();
  }
}
