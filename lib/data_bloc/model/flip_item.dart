class FlipItem {
  final int id;
  late  double? roi;
  final int? low;
  final int? high;
  final int? buyLimit;
  final String name;
  int get diff => (this.high??0)-(this.low??0);

  FlipItem(this.id, this.name, {this.roi, this.low, this.high, this.buyLimit}) {
    if(this.low != null && this.high != null) {
      this.roi = ((this.high! / this.low!) -1) * 100;
    }
  }
}