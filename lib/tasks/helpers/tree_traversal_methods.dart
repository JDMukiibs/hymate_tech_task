import 'package:hymate_tech_task/api/models/models.dart';

/// Iterative traversal (DFS) — avoids recursion and is safe for deep trees.
/// Returns a list of all datapoint IDs in the given category and its subcategories.
/// Would need to be refactored to perhaps use compute if performance becomes an issue.
List<String> getAllDatapointIdsInCategoryIterative(
  DatapointHierarchyNode category,
) {
  final ids = <String>[];
  final stack = <DatapointHierarchyNode>[category];

  while (stack.isNotEmpty) {
    final node = stack.removeLast();

    if (node.isDatapoint && node.id != null) {
      ids.add(node.id!);
    }

    final children = node.children;
    if (children != null && children.isNotEmpty) {
      // push children onto stack for DFS
      for (final child in children) {
        stack.add(child);
      }
    }
  }

  return ids;
}

/// Returns a list of all datapoint nodes in the given category and its subcategories.
List<DatapointHierarchyNode> getAllDatapointsInCategoryIterative(
    DatapointHierarchyNode category,
    ) {
  final dataPointsInCategory = <DatapointHierarchyNode>[];
  final stack = <DatapointHierarchyNode>[category];

  while (stack.isNotEmpty) {
    final node = stack.removeLast();

    if (node.isDatapoint && node.id != null) {
      dataPointsInCategory.add(node);
    }

    final children = node.children;
    if (children != null && children.isNotEmpty) {
      // push children onto stack for DFS
      for (final child in children) {
        stack.add(child);
      }
    }
  }

  return dataPointsInCategory;
}
