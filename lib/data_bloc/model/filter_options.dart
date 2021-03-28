import 'package:osrs_flipper/utils/ranged_property.dart';

class FilterOptions {
  RangedProperty<int>? gpValue;
  RangedProperty<double>? roi;
  RangedProperty<int>? buyLimit;
  RangedProperty<int>? lowPriceVolume;
  RangedProperty<int>? highPriceVolume;

  FilterOptions({
    this.gpValue,
    this.roi,
    this.buyLimit,
    this.lowPriceVolume,
    this.highPriceVolume,
  });
}
