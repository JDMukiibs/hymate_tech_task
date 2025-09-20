import 'package:flutter/material.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/shared/shared.dart';
import 'package:hymate_tech_task/tasks/widgets/hierarchy_node.dart';

class CategoryTile extends StatefulWidget {
  const CategoryTile({
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
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme.copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(left: widget.level * 16.0),
        child: ExpansionTile(
          key: ValueKey(widget.node.id ?? widget.node.name),
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          leading: Icon(
            Icons.folder,
            color: widget.color,
          ),
          title: Text(
            widget.node.name,
            style: context.theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          // We keep the Checkbox in the trailing.
          // The ExpansionTile itself provides an expand/collapse icon.
          trailing: Checkbox(
            // This Checkbox should only toggle selection
            value: widget.isSelected,
            onChanged: (newValue) {
              // Only call onToggle if the checkbox's value actually changes
              if (newValue != null && newValue != widget.isSelected) {
                widget.onToggle();
              }
            },
          ),
          children:
              widget.node.children
                  ?.map(
                    (child) => HierarchyNode(
                      node: child,
                      level: widget.level + 1,
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
