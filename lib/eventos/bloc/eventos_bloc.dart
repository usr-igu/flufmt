import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flufmt/eventos/bloc/eventos.dart';
import 'package:flufmt/eventos/eventos_repository.dart';
import 'package:flufmt/service_locator.dart';

class EventosBloc extends Bloc<EventosEvent, EventosState> {
  final _eventosService = getIt.get<EventosService>();

  EventosBloc();

  @override
  EventosState get initialState => EventosInitial();

  @override
  Stream<EventosState> mapEventToState(event) async* {
    try {
      if (event is LoadEventos) {
        yield EventosLoading();
        final _eventos = await _eventosService.getEventos();
        yield EventosLoaded(eventos: _eventos);
      }
    } catch (e) {
      yield EventosError(error: e.message);
    }
  }
}
