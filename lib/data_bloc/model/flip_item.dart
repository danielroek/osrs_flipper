import 'package:json_annotation/json_annotation.dart';

part 'flip_item.g.dart';

@JsonSerializable()
class FlipItem {
  final int id;
  late double? roi;
  final int? low;
  final int? high;
  final int? buyLimit;
  final int? lowPriceVolume;
  final int? highPriceVolume;
  final String name;

  int get diff => (this.high ?? 0) - (this.low ?? 0);

  FlipItem(this.id, this.name,
      {this.roi,
      this.low,
      this.high,
      this.buyLimit,
      this.lowPriceVolume,
      this.highPriceVolume}) {
    if (this.low != null && this.high != null) {
      this.roi = ((this.high! / this.low!) - 1) * 100;
    }
  }

  factory FlipItem.fromJson(Map<String,dynamic> json) => _$FlipItemFromJson(json);
  Map<String, dynamic> toJson() => _$FlipItemToJson(this);
}
