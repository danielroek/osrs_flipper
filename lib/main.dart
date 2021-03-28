import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrs_flipper/bloc_providers.dart';
import 'package:osrs_flipper/data_bloc/data_bloc.dart';
import 'package:osrs_flipper/home/home_view.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    DataBloc().getFlipItemsFromAPI();


    return MaterialApp(
      title: 'Osrs Flipper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

