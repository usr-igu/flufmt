import 'dart:async';

import 'package:flufmt/noticia/bloc/noticia_event.dart';
import 'package:flufmt/noticia/bloc/noticia_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flufmt/noticia/noticia_repository.dart';
import 'package:flufmt/service_locator.dart';

class NoticiaBloc extends Bloc<NoticiaEvent, NoticiaState> {
  final _noticiaService = getIt.get<NoticiaService>();

  @override
  NoticiaState get initialState => NoticiaInitial();

  @override
  Stream<NoticiaState> mapEventToState(event) async* {
    if (event is LoadNoticias) {
      try {
        yield NoticiaLoading();
        final _noticias =
            await _noticiaService.getNoticias(event.inicio, event.quantidade);
        yield NoticiaLoaded(noticias: _noticias);
      } catch (e) {
        yield NoticiaError(error: e.toString());
      }
    }
  }
}
