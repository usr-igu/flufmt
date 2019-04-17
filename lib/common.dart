import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:meta/meta.dart';

class CustomColors {
  static const Color AZUL_UFMT = const Color(0xFF010033);
}

class Constants {
  static const String URL_SITE_UFMT = 'http://www.ufmt.br';
}

void disparaUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possivel disparar: $url';
  }
}

void compartilhaNoticia(
    {@required String titulo, @required String idNoticia}) async {
  final s =
      '$titulo ${Constants.URL_SITE_UFMT}/ufmt/site/noticia/visualizar/$idNoticia/Cuiaba';
  await Share.share(s);
}

void compartilhaEvento(
    {@required String titulo, @required String idEvento}) async {
  final s =
      '$titulo ${Constants.URL_SITE_UFMT}/ufmt/site/divulgacao/visualizar/$idEvento/Cuiaba';
  await Share.share(s);
}
