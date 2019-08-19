import 'package:equatable/equatable.dart';

abstract class NoticiaEvent extends Equatable {
  NoticiaEvent([List props = const []]) : super(props);
}

class LoadNoticias extends NoticiaEvent {
  final int pagina;

  LoadNoticias({this.pagina = 0}) : super([pagina]);

  @override
  String toString() => 'LoadNoticias { página: $pagina }';
}

class LoadNextPage extends NoticiaEvent {
  @override
  String toString() => 'LoadNextPageNoticias';
}
