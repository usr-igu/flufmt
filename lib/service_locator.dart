import 'package:flufmt/eventos/bloc/eventos.dart';
import 'package:flufmt/eventos/eventos_repository.dart';
import 'package:flufmt/noticia/bloc/noticia_bloc.dart';
import 'package:flufmt/noticia/noticia_repository.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<NoticiaService>(NoticiaService(http.Client()));
  getIt.registerSingleton<EventosService>(EventosService(http.Client()));

  getIt.registerSingleton<NoticiaBloc>(NoticiaBloc(itemsPorPagina: 20));
  getIt.registerSingleton<EventosBloc>(EventosBloc());
}
