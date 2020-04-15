class Historical {
  DateTime date;
  double open;
  double high;
  double low;
  String close;
  double adjClose;
  double volume;
  double unadjustedVolume;
  double change;
  double changePercent;
  double vwap;
  String label;
  double changeOverTime;

  Historical({
    this.adjClose,
    this.change,
    this.changeOverTime,
    this.changePercent,
    this.close,
    this.date,
    this.high,
    this.label,
    this.low,
    this.open,
    this.unadjustedVolume,
    this.volume,
    this.vwap,
  });

  factory Historical.fromJson(Map<String, dynamic> json) {
    return Historical(
      date: DateTime.parse(json["historical"]["date"]),
      open: json["historical"]["open"].toDouble(),
      high: json["historical"]["high"].toDouble(),
      low: json["historical"]["low"].toDouble(),
      close: json["historical"]["close"].toString(),
      adjClose: json["historical"]["adjClose"].toDouble(),
      volume: json["historical"]["volume"].toDouble(),
      unadjustedVolume: json["historical"]["unadjustedVolume"].toDouble(),
      change: json["historical"]["change"].toDouble(),
      changePercent: json["historical"]["changePercent"].toDouble(),
      vwap: json["historical"]["vwap"].toDouble(),
      label: json["historical"]["label"],
      changeOverTime: json["historical"]["changeOverTime"].toDouble(),
    );
  }
}
