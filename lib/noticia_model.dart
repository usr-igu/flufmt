class NoticiaModel {
  final String idNoticia;
  final String idCategoria;
  final String descricaoCategoria;
  final String tituloNoticia;
  final String dataHoraNoticia;
  final String assuntoNoticia;
  final String chamadaNoticia;
  final String imagemNoticia;
  final String isDestaque;
  final String textoNoticia;
  final String idCampus;
  final String descricaoCampus;
  final String isTomeNota;
  final String idEditorial;
  final String descricaoEditorial;

  NoticiaModel.fromJson(Map<String, dynamic> json)
      : idNoticia = json['IDNoticia'],
        idCategoria = json['IDCategoria'],
        descricaoCategoria = json['DescricaoCategoria'],
        tituloNoticia = json['TituloNoticia'],
        dataHoraNoticia = json['DataHoraNoticia'],
        assuntoNoticia = json['AssuntoNoticia'],
        chamadaNoticia = json['ChamadaNoticia'],
        imagemNoticia = json['ImagemNotitica'],
        isDestaque = json['IsDestaque'],
        textoNoticia = json['TextoNoticia'],
        idCampus = json['IDCampus'],
        descricaoCampus = json['DescricaoCampus'],
        isTomeNota = json['IsTomeNota'],
        idEditorial = json['IDEditorial'],
        descricaoEditorial = json['DescricaoEditorial'];
}
