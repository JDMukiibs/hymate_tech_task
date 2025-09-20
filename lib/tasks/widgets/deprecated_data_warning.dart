import 'package:flutter/material.dart';
import 'package:hymate_tech_task/shared/layout/layout.dart';

class DeprecatedDataWarning extends StatelessWidget {
  const DeprecatedDataWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allPadding8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: .1),
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.warning_amber_outlined,
              color: Colors.orange,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'This data is marked as deprecated by the API',
                style: TextStyle(
                  color: Colors.orange.shade700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
