class DataPoint {
  // "kW", "MW", etc.

  DataPoint({
    required this.id,
    required this.label,
    this.timeSeries,
    this.categoryPath,
    this.unit,
  });

  /// The technical identifier (e.g., "CNS_1_BSL_1_ELCPOWERIN")
  final String id;

  /// User-friendly label (e.g., "Electrical consumption")
  final String label;

  /// The actual time-series data (populated after API response)
  final List<TimeSeriesValue>? timeSeries;

  /// Category path for hierarchical organization
  final List<String>? categoryPath; // ["Production", "Electrical production"]

  /// Data type or unit information
  final String? unit;
}

class TimeSeriesValue {
  TimeSeriesValue(this.timestamp, this.value);
  final DateTime timestamp;
  final double value;
}
