import 'package:flutter/material.dart';

class NoValidRenewableDataWidget extends StatelessWidget {
  const NoValidRenewableDataWidget({
    required this.metricName,
    super.key,
  });

  final String metricName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline,
            size: 64,
            color: Colors.amber,
          ),
          const SizedBox(height: 16),
          Text(
            'No Valid $metricName Data',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'The API returned data but all values are zero or null',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
