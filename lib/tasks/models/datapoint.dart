class DataPoint {
  DataPoint({
    required this.id,
    required this.label,
    this.timeSeries,
    this.unit,
  });

  /// The technical identifier (e.g., "CNS_1_BSL_1_ELCPOWERIN")
  final String id;

  /// User-friendly label (e.g., "Electrical consumption")
  final String label;

  /// The actual time-series data (populated after API response)
  final List<TimeSeriesValue>? timeSeries;

  /// Data type or unit information such as "kW" or "MW", etc.
  final String? unit;
}

class TimeSeriesValue {
  TimeSeriesValue(this.timestamp, this.value);
  final DateTime timestamp;
  final double value;
}
