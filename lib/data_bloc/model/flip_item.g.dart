// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flip_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlipItem _$FlipItemFromJson(Map<String, dynamic> json) {
  return FlipItem(
    json['id'] as int,
    json['name'] as String,
    roi: (json['roi'] as num?)?.toDouble(),
    low: json['low'] as int?,
    high: json['high'] as int?,
    buyLimit: json['buyLimit'] as int?,
    lowPriceVolume: json['lowPriceVolume'] as int?,
    highPriceVolume: json['highPriceVolume'] as int?,
  );
}

Map<String, dynamic> _$FlipItemToJson(FlipItem instance) => <String, dynamic>{
      'id': instance.id,
      'roi': instance.roi,
      'low': instance.low,
      'high': instance.high,
      'buyLimit': instance.buyLimit,
      'lowPriceVolume': instance.lowPriceVolume,
      'highPriceVolume': instance.highPriceVolume,
      'name': instance.name,
    };
