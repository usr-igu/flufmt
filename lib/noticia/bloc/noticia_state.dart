import 'package:equatable/equatable.dart';
import 'package:flufmt/noticia/noticia_model.dart';
import 'package:flutter/foundation.dart';

abstract class NoticiasState extends Equatable {
  NoticiasState([List props = const []]) : super(props);
}

class NoticiasInitial extends NoticiasState {
  @override
  String toString() => 'NoticiasInitial';
}

class NoticiasEmpty extends NoticiasState {
  @override
  String toString() => 'NoticiasEmpty';
}

class NoticiasLoading extends NoticiasState {
  @override
  String toString() => 'NoticiasLoading';
}

class NoticiasLoaded extends NoticiasState {
  final List<NoticiaModel> noticias;

  NoticiasLoaded({@required this.noticias})
      : assert(noticias != null),
        super([noticias]);

  @override
  String toString() => 'NoticiasLoaded';
}

class NoticiasError extends NoticiasState {
  final String error;

  NoticiasError({@required this.error})
      : assert(error != null),
        super([error]);

  @override
  String toString() => 'NoticiasError { error: $error }';
}
