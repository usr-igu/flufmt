import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flufmt/noticia/bloc/noticia_event.dart';
import 'package:flufmt/noticia/bloc/noticia_state.dart';
import 'package:flufmt/noticia/noticia_repository.dart';
import 'package:flufmt/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class NoticiaBloc extends Bloc<NoticiaEvent, NoticiasState> {
  final _noticiaService = getIt.get<NoticiaService>();
  final int itemsPorPagina;
  var _pagina = 0;

  NoticiaBloc({@required this.itemsPorPagina}) : assert(itemsPorPagina != null);

  @override
  NoticiasState get initialState => NoticiasInitial();

  @override
  Stream<NoticiaEvent> transform(Stream<NoticiaEvent> events) {
    return (events as Observable<NoticiaEvent>)
        .debounce(Duration(milliseconds: 300));
  }

  @override
  Stream<NoticiasState> mapEventToState(event) async* {
    try {
      if (event is LoadNoticias) {
        yield NoticiasLoading();
        final _noticias =
            await _noticiaService.getNoticias(_pagina, itemsPorPagina);
        yield NoticiasLoaded(noticias: _noticias);
      }
      if (event is LoadNextPage) {
        if (currentState is NoticiasLoaded) {
          final _noticias =
              await _noticiaService.getNoticias(++_pagina, itemsPorPagina);
          yield NoticiasLoaded(
              noticias: (currentState as NoticiasLoaded).noticias + _noticias);
        }
      }
    } catch (e) {
      yield NoticiasError(error: e.message);
    }
  }
}
