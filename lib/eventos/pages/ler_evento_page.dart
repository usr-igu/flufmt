import 'package:flufmt/eventos/evento_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flufmt/common.dart';

class LerEventoPage extends StatelessWidget {
  final EventoModel evento;

  const LerEventoPage({Key key, @required this.evento})
      : assert(evento != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do evento'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: () => compartilhaEvento(
              titulo: evento.tituloDivulgacao,
              idEvento: evento.idDivulgacao,
            ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                evento.tituloDivulgacao,
                style: Theme.of(context).textTheme.title,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '${_converteDataHora(evento.dataInicio, evento.dataFim)}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Divider(),
              Html(
                data: evento.textoDivulgacao,
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

  String _converteDataHora(String dataInicio, String dataFim) {
    try {
      final _dataInicio = DateFormat.MMMMd().format(DateTime.parse(dataInicio));
      final _dataFim = DateFormat.MMMMd().format(DateTime.parse(dataFim));
      return 'Do dia $_dataInicio até $_dataFim';
    } catch (e) {
      return '';
    }
  }
}
