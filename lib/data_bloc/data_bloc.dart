import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:osrs_flipper/data_bloc/model/flip_item.dart';
import 'package:osrs_flipper/data_bloc/model/sort_value.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial());
  Dio dio = Dio();

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if(event is LoadData) {
      yield HasDataState(await getFlipItemsFromAPI());
    }
  }

  Future<List<FlipItem>> getFlipItemsFromAPI () async {
    this.dio.options.baseUrl = 'https://prices.runescape.wiki/api/v1/osrs';

    List<FlipItem> l = [];
    Response response = await dio.get('/5m');

    Map<String, dynamic> data = response.data['data'];

    print(data.keys);

    data.keys.forEach((key) {
      dynamic apiObj = data[key];

      FlipItem n = new FlipItem(int.parse(key),'', roi:null, low: apiObj['avgLowPrice'], high: apiObj['avgHighPrice'], buyLimit:null);

      l.add(n);
    });

    return l;
  }
}
