import 'package:equatable/equatable.dart';

abstract class EventosEvent extends Equatable {
  EventosEvent([List props = const []]) : super(props);
}

class LoadEventos extends EventosEvent {
  LoadEventos() : super();

  @override
  String toString() => 'LoadEventos';
}
