import 'package:json_annotation/json_annotation.dart';

part 'flip_item.g.dart';

@JsonSerializable()
class FlipItem {
   int id;
   double? roi;
   int? low;
   int? high;
   int? buyLimit;
   int? lowPriceVolume;
   int? highPriceVolume;
   int? latestLow;
   DateTime? lowTime;
   int? latestHigh;
   DateTime? highTime;
   String name;
   String image;

  int get diff => (this.high ?? 0) - (this.low ?? 0);
  int get potentialProfit => (this.diff * (this.buyLimit??0));
  int get totalInvestment => ((this.low??0) * (this.buyLimit ?? 0));

  FlipItem(this.id, this.name, this.image,
      {this.roi,
      this.low,
      this.high,
      this.buyLimit,
      this.lowPriceVolume,
      this.latestLow,
      this.lowTime,
      this.latestHigh,
      this.highTime,
      this.highPriceVolume}) {
    if (this.low != null && this.high != null) {
      this.roi = ((this.high! / this.low!) - 1) * 100;
    }
  }

  factory FlipItem.fromJson(Map<String, dynamic> json) =>
      _$FlipItemFromJson(json);

  Map<String, dynamic> toJson() => _$FlipItemToJson(this);
}
