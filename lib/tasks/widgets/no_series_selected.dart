import 'package:flutter/material.dart';

class NoSeriesSelectedWidget extends StatelessWidget {
  const NoSeriesSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.deselect_outlined,
            size: 64,
            color: Colors.blue,
          ),
          SizedBox(height: 16),
          Text(
            'No Series Selected',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please select at least one series to display the chart',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
