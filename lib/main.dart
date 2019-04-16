import 'package:bloc/bloc.dart';
import 'package:flufmt/bloc_delegate.dart';
import 'package:flufmt/noticia/noticias_page.dart';
import 'package:flufmt/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  BlocSupervisor().delegate = SimpleBlocDelegate();
  setupServiceLocator();
  runApp(MyApp());
}

const Color AZUL_UFMT = const Color(0xFF1C306D);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flufmt',
      theme: ThemeData.light().copyWith(
        primaryColor: AZUL_UFMT,
        accentColor: AZUL_UFMT,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AZUL_UFMT,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              title: TextStyle(fontSize: 24.0, color: AZUL_UFMT),
              body1: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
        const Locale('en', 'US'),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: NoticiasPage(),
      ),
    );
  }
}
