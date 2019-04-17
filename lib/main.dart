import 'package:bloc/bloc.dart';
import 'package:flufmt/bloc_delegate.dart';
import 'package:flufmt/common.dart';
import 'package:flufmt/eventos/pages/eventos_page.dart';
import 'package:flufmt/noticia/pages/noticias_page.dart';
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flufmt',
      theme: ThemeData.light().copyWith(
        primaryColor: CustomColors.AZUL_UFMT,
        accentColor: CustomColors.AZUL_UFMT,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: CustomColors.AZUL_UFMT,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              title: TextStyle(fontSize: 24.0, color: CustomColors.AZUL_UFMT),
              body1: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              color: Colors.white,
              textTheme: TextTheme(
                title: TextStyle(color: Colors.black, fontSize: 20),
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
      ),
      home: SafeArea(child: HomePage()),
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> _tabs = [
    Tab(text: 'Notícias'),
    Tab(text: 'Eventos'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: TabBar(
          controller: _tabController,
          labelColor: CustomColors.AZUL_UFMT,
          indicatorColor: CustomColors.AZUL_UFMT,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          NoticiasPage(),
          EventosPage(),
        ],
      ),
    );
  }
}
