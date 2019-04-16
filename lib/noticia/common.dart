import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:meta/meta.dart';

const URL_SITE_UFMT = 'http://www.ufmt.br';
const Color AZUL_UFMT = const Color(0xFF1C306D);


void disparaUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possivel disparar: $url';
  }
}

void compartilhaNoticia({@required String titulo, @required String idNoticia}) async {
  final s = '$titulo $URL_SITE_UFMT/ufmt/site/noticia/visualizar/$idNoticia/Cuiaba';
  await Share.share(s);
}
