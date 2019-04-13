import 'dart:convert';

import 'package:flufmt/noticia/noticia_model.dart';
import 'package:http/http.dart' as http;

class NoticiaService {
  final http.Client _client;

  NoticiaService(this._client);

  Future<List<NoticiaModel>> getNoticias(int inicio, int quantidade) async {
    final response = await _client
        .get('http://www.ufmt.br/webservice/teste.php/$inicio/$quantidade');

    if (response.statusCode == 200) {
      return await jsonDecode(response.body)
          .map<NoticiaModel>((noticia) => NoticiaModel.fromJson(noticia))
//          .where((noticia) => noticia.descricaoCategoria == 'Geral')
          .toList();
    } else {
      throw Exception(
          'Erro na requisição das notícias: ${response.statusCode}');
    }
  }
}
