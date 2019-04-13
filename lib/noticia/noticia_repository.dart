import 'dart:convert';

import 'package:flufmt/noticia/noticia_model.dart';
import 'package:http/http.dart' as http;

class NoticiaService {
  final http.Client _client;

  NoticiaService(this._client);

  Future<List<NoticiaModel>> getNoticias(int pagina, int quantidade) async {
    try {
      final request = _client.get(
          'http://www.ufmt.br/webservice/teste.php/${pagina * quantidade}/$quantidade');

      final response = await request.timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        return await jsonDecode(response.body)
            .map<NoticiaModel>((noticia) => NoticiaModel.fromJson(noticia))
            .where((noticia) => noticia.descricaoCategoria == 'Geral')
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
