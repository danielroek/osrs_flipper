// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flip_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlipItem _$FlipItemFromJson(Map<String, dynamic> json) {
  return FlipItem(
    json['id'] as int,
    json['name'] as String,
    json['image'] as String,
    roi: (json['roi'] as num?)?.toDouble(),
    low: json['low'] as int?,
    high: json['high'] as int?,
    buyLimit: json['buyLimit'] as int?,
    lowPriceVolume: json['lowPriceVolume'] as int?,
    latestLow: json['latestLow'] as int?,
    lowTime: json['lowTime'] == null
        ? null
        : DateTime.parse(json['lowTime'] as String),
    latestHigh: json['latestHigh'] as int?,
    highTime: json['highTime'] == null
        ? null
        : DateTime.parse(json['highTime'] as String),
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
      'latestLow': instance.latestLow,
      'lowTime': instance.lowTime?.toIso8601String(),
      'latestHigh': instance.latestHigh,
      'highTime': instance.highTime?.toIso8601String(),
      'name': instance.name,
      'image': instance.image,
    };
