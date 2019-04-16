import 'package:flufmt/noticia/noticia_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter_html/flutter_html.dart';

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
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                noticia.tituloNoticia,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${_converteDataHora(noticia.dataHoraNoticia)}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Text(noticia.assuntoNoticia),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Html(
                data: noticia.textoNoticia,
                renderNewlines: true,
                useRichText: true,
              ),
            ),
            SizedBox(
              height: 64.0,
            )
          ],
        ),
      ),
    );
  }

  String _converteDataHora(String data) {
    final date = DateTime.parse(data);
    final elapsed = DateTime.now().difference(date);
    if (elapsed.inDays < 1) {
      if (elapsed.inHours < 1) {
        return 'há aproximadamente ${elapsed.inMinutes} minutos atrás';
      }
      return 'há aproximadamente ${elapsed.inHours} horas atrás';
    }
    return DateFormat.MMMMEEEEd().add_Hm().format(date);
  }
}
