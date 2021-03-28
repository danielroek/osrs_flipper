import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:osrs_flipper/data_bloc/model/flip_item.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(HasDataState());

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}