class EventoModel {
  final String idDivulgacao;
  final String tituloDivulgacao;
  final String textoDivulgacao;
  final String dataInicio;
  final String dataFim;
  final String link;
  final String isExterno;
  final String idCampus;
  final String descricaoCampus;
  final String iconeDivulgacao;
  final String aliasCampus;

  EventoModel.fromJson(Map<String, dynamic> json)
      : idDivulgacao = json['IDDivulgacao'],
        tituloDivulgacao = json['TituloDivulgacao'],
        textoDivulgacao = json['TextoDivulgacao'],
        dataInicio = json['DataInicio'],
        dataFim = json['Datafim'],
        link = json['link'],
        isExterno = json['IsExterno'],
        idCampus = json['IDCampus'],
        descricaoCampus = json['DescricaoCampus'],
        iconeDivulgacao = json['IconeDivulgacao'],
        aliasCampus = json['AliasCampus'];
}
