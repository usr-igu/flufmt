import 'dart:convert';

import 'package:flufmt/eventos/evento_model.dart';
import 'package:http/http.dart' as http;

class EventosService {
  final http.Client _client;

  EventosService(this._client);

  Future<List<EventoModel>> getEventos() async {
    try {
      final request = _client.get('http://www.ufmt.br/webservice/acontece.php');

      final response = await request.timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        return await jsonDecode(response.body)
            .map<EventoModel>((evento) => EventoModel.fromJson(evento))
            .toList();
      } else {
        throw Exception(
            'Erro na requisição das notícias: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
          'Não foi possível conectar ao servidor, verifique sua conexão com a internet.');
    }
  }
}
