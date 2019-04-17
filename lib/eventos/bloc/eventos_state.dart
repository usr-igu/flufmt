import 'package:equatable/equatable.dart';
import 'package:flufmt/eventos/evento_model.dart';
import 'package:meta/meta.dart';

abstract class EventosState extends Equatable {
  EventosState([List props = const []]) : super(props);
}

class EventosInitial extends EventosState {
  @override
  String toString() => 'EventosInitial';
}

class EventosEmpty extends EventosState {
  @override
  String toString() => 'EventosEmpty';
}

class EventosLoading extends EventosState {
  @override
  String toString() => 'EventosLoading';
}

class EventosLoaded extends EventosState {
  final List<EventoModel> eventos;

  EventosLoaded({@required this.eventos})
      : assert(eventos != null),
        super([eventos]);

  @override
  String toString() => 'EventosLoaded';
}

class EventosError extends EventosState {
  final String error;

  EventosError({@required this.error})
      : assert(error != null),
        super([error]);

  @override
  String toString() => 'EventosError { error: $error }';
}
