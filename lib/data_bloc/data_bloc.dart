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
  DataBloc() : super(DataInitial()) {
    fetchData();

  }
  Dio dio = Dio();

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if(event is LoadData) {
      yield HasDataState(await getFlipItemsFromAPI());
    }
  }

  Future<Map<String, dynamic>> updateItemNames() async {
    this.dio.options.baseUrl = 'https://www.osrsbox.com/osrsbox-db';

    Response response = await dio.get('/items-summary.json');

    return response.data;
  }

  Future<List<FlipItem>> getFlipItemsFromAPI () async {
    this.dio.options.baseUrl = 'https://prices.runescape.wiki/api/v1/osrs';

    List<FlipItem> l = [];
    Response response = await dio.get('/5m');

    Map<String, dynamic> data = response.data['data'];

    print("test");
    print(data.keys);

    data.keys.forEach((key) {
      dynamic apiObj = data[key];


      FlipItem n = new FlipItem(int.parse(key),'', roi:null, low: apiObj['avgLowPrice'], high: apiObj['avgHighPrice'], buyLimit:null);

      l.add(n);
    });

    return _sort(l);
  }

  void fetchData() {
    add(LoadData());
    Stream.periodic(Duration(minutes: 5)).listen((_) {
      add(LoadData());
    });
  }

  List<FlipItem> _sort(List<FlipItem> l) {
    if(this.state.sortBy == SortValue.DIFF) {
      l.removeWhere((element) => (element.high == null || element.low == null));
      l.sort((a,b) {
        return b.diff.compareTo(a.diff);
      });
    }

    return l;
  }
}
