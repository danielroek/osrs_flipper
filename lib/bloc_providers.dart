import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_bloc/data_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
    BlocProvider<DataBloc>(
      create: (BuildContext context) => DataBloc(),
    ),
  ];
}