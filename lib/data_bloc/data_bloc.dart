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
  final box = GetStorage();

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is LoadData) {
      yield HasDataState(await getFlipItemsFromAPI());
    }
  }

  Future<Map<String, dynamic>> updateFullItemInformation() async {
    this.dio.options.baseUrl = "https://www.osrsbox.com/osrsbox-db";

    Response response = await dio.get('/items-complete.json');
    await box.write('fullItemData', response.data);
    await box.save();
    return response.data;
  }

  Future<Map<String, dynamic>> getFullItemInformation({bool update = false}) async {
    if(!box.hasData('fullItemData') || update) {
      await this.updateFullItemInformation();
    }

    return await box.read('fullItemData');
  }

  Future<List<FlipItem>> getFlipItemsFromAPI() async {
    Map<String, dynamic> itemInformation = await this.getFullItemInformation();
    this.dio.options.baseUrl = 'https://prices.runescape.wiki/api/v1/osrs';

    List<FlipItem> l = [];
    Response response = await dio.get('/5m');

    Map<String, dynamic> data = response.data['data'];

    data.keys.forEach((key) async {
      dynamic apiObj = data[key];
      if (itemInformation[key] == null) { // Update itemInformation if there is missing info ( Does not 100% guarantee information is present )
        itemInformation = await this.getFullItemInformation(update: true);
      }

      FlipItem n = new FlipItem(
          int.parse(key),  // Id
          itemInformation[key]['name'] ?? '', // Name
          itemInformation[key]['icon'] ?? '', // Image
          roi: null,
          low: apiObj['avgLowPrice'],
          high: apiObj['avgHighPrice'],
          buyLimit: itemInformation[key]['buy_limit'] ?? 0,
          lowPriceVolume: apiObj['lowPriceVolume'],
          highPriceVolume: apiObj['highPriceVolume']);
      l.add(n);
    });

    l = await _fillMissingDataWithLatest(l, itemInformation);
    return _sort(l);
  }

  void fetchData() {
    add(LoadData());
    Stream.periodic(Duration(seconds: 30)).listen((_) {
      add(LoadData());
    });
  }

  List<FlipItem> _sort(List<FlipItem> l) {
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
        return b.potentialProfit.compareTo(a.potentialProfit);
      });
    }
    return l;
  }

  Future<List<FlipItem>> _fillMissingDataWithLatest(List<FlipItem> l, Map<String, dynamic> itemInformation) async {
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
            itemInformation[key]['name'] ?? '',
            itemInformation[key]['icon'] ?? '', // Image
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
