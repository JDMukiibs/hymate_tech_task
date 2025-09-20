import 'package:flutter/material.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/shared/shared.dart';

class DatapointTile extends StatelessWidget {
  const DatapointTile({
    required this.node,
    required this.level,
    required this.isSelected,
    required this.color,
    required this.onToggle,
    super.key,
  });

  final DatapointHierarchyNode node;
  final int level;
  final bool isSelected;
  final Color color;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        title: Text(
          node.name,
          style: context.theme.textTheme.bodyMedium,
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (_) => onToggle(),
        ),
        onTap: onToggle,
      ),
    );
  }
}
