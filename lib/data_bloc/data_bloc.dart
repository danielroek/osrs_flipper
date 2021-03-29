import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
    if (event is LoadData) {
      yield HasDataState(await getFlipItemsFromAPI());
    }
  }

  Future<Map<String, dynamic>> updateItemNames() async {
    final box = GetStorage();
    this.dio.options.baseUrl = 'https://www.osrsbox.com/osrsbox-db';

    Response response = await dio.get('/items-summary.json');
    await box.write('names', response.data);
    await box.save();
    return response.data;
  }

  Future<Map<String, dynamic>> getItemNames({bool update = true}) async {
    final box = GetStorage();

    if (!box.hasData('names') || update) {
      this.updateItemNames();
    }

    return await box.read('names');
  }

  Future<List<FlipItem>> getFlipItemsFromAPI() async {
    Map<String, dynamic> itemNames = await this.getItemNames();

    this.dio.options.baseUrl = 'https://prices.runescape.wiki/api/v1/osrs';

    List<FlipItem> l = [];
    Response response = await dio.get('/5m');

    Map<String, dynamic> data = response.data['data'];
    data.keys.forEach((key) async {
      dynamic apiObj = data[key];
      if (itemNames[key] == null) {
        itemNames = await this.getItemNames(update: true);
      }

      FlipItem n = new FlipItem(int.parse(key), itemNames[key]['name'] ?? '',
          roi: null,
          low: apiObj['avgLowPrice'],
          high: apiObj['avgHighPrice'],
          buyLimit: null,
          lowPriceVolume: apiObj['lowPriceVolume'],
          highPriceVolume: apiObj['highPriceVolume']);

      l.add(n);
    });
    debugPrint('l size is now: ${l.length}');
    l = await _fillMissingDataWithLatest(l);
    debugPrint('l size is now2: ${l.length}');
    return _sort(l);
  }

  void fetchData() {
    add(LoadData());
    Stream.periodic(Duration(seconds: 10)).listen((_) {
      add(LoadData());
    });
  }

  List<FlipItem> _sort(List<FlipItem> l) {
    debugPrint('ping');
    if (this.state.sortBy == SortValue.DIFF) {
      l.removeWhere((element) => (element.high == null || element.low == null));
      l.removeWhere((element) => (element.high ?? 0) < 1000);
      l.removeWhere((element) => (element.roi ?? 0) < 1);
      l.removeWhere((element) => ((element.lowPriceVolume ?? 0) < 10 &&
          (element.highPriceVolume ?? 0) < 10));
      // l.removeWhere((element) => !element.name.contains('orna'));
      // l.removeWhere((element) => (element.lowPriceVolume ?? 0 < 15 || element.highPriceVolume! < 15));
      // l.removeWhere((element) => (element.low ?? 0 > 150000));
      l.sort((a, b) {
        return b.diff.compareTo(a.diff);
      });
    }
    debugPrint('l size is now3: ${l.length}');
    return l;
  }

  Future<List<FlipItem>> _fillMissingDataWithLatest(List<FlipItem> l) async {
    Map<String, dynamic> itemNames = await this.getItemNames();
    this.dio.options.baseUrl = 'https://prices.runescape.wiki/api/v1/osrs';
    Response response = await dio.get('/latest');
    Map<String, dynamic> data = response.data['data'];
    data.keys.forEach((key) {
      dynamic apiObj = data[key];
      if (l.any((element) => element.id == int.parse(key))) {
        //List contains item => fill empty data
        int i = l.indexWhere((item) => item.id == int.parse(key));
        if (l.elementAt(i).high == null) {
          l.elementAt(i).high = apiObj['high'];
          l.elementAt(i).highTime = DateTime.fromMillisecondsSinceEpoch(apiObj['highTime'] ??0);
        } else if (l.elementAt(i).low == null) {
          l.elementAt(i).low = apiObj['low'];
          l.elementAt(i).lowTime = DateTime.fromMillisecondsSinceEpoch(apiObj['lowTime'] ?? 0);
        }
      } else {
        l.add(
          FlipItem(
            int.parse(key),
            itemNames[key]['name'] ?? '',
            roi: null,
            low: apiObj['low'],
            high: apiObj['high'],
            highTime: DateTime.fromMillisecondsSinceEpoch(apiObj['highTime'] ?? 0),
            lowTime: DateTime.fromMillisecondsSinceEpoch(apiObj['lowTime'] ?? 0),
          ),
        );
      }
    });
    return l;
  }
}
