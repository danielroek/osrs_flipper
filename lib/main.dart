import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:osrs_flipper/bloc_providers.dart';
import 'package:osrs_flipper/home/home_view.dart';

void main() async {
  await GetStorage.init();
  runApp(MultiBlocProvider(providers: BlocProviders.providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Osrs Flipper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
