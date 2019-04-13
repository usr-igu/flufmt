import 'package:equatable/equatable.dart';
import 'package:flufmt/noticia/noticia_model.dart';
import 'package:flutter/foundation.dart';

abstract class NoticiaState extends Equatable {
  NoticiaState([List props = const []]) : super(props);
}

class NoticiaInitial extends NoticiaState {
  @override
  String toString() => 'NoticiaInitial';
}

class NoticiaLoading extends NoticiaState {
  @override
  String toString() => 'NoticiaLoading';
}

class NoticiaLoaded extends NoticiaState {
  final List<NoticiaModel> noticias;

  NoticiaLoaded({@required this.noticias})
      : assert(noticias != null),
        super([noticias]);

  @override
  String toString() => 'NoticiaLoaded';
}

class NoticiaError extends NoticiaState {
  final String error;

  NoticiaError({@required this.error})
      : assert(error != null),
        super([error]);

  @override
  String toString() => 'NoticiaError';
}
