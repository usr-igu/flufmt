import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NoticiaEvent extends Equatable {
  NoticiaEvent([List props = const []]) : super(props);
}

class LoadNoticias extends NoticiaEvent {
  final int quantidade;
  final int inicio;

  LoadNoticias({this.inicio = 0, @required this.quantidade})
      : super([inicio, quantidade]);

  @override
  String toString() => 'LoadNoticias';
}
