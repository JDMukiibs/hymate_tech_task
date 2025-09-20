import 'package:flutter_test/flutter_test.dart';
import 'package:hymate_tech_task/api/models/models.dart';
import 'package:hymate_tech_task/tasks/helpers/tree_traversal_methods.dart';

void main() {
  test(
    'getAllDatapointIdsInCategoryIterative returns all ids in nested tree',
    () {
      final leaf1 = DatapointHierarchyNode(name: 'leaf1', id: 'id1');
      final leaf2 = DatapointHierarchyNode(name: 'leaf2', id: 'id2');
      final sub = DatapointHierarchyNode(name: 'sub', children: [leaf1, leaf2]);
      final root = DatapointHierarchyNode(name: 'root', children: [sub]);

      final ids = getAllDatapointIdsInCategoryIterative(root);

      // order is not guaranteed (DFS stack), so compare as sets
      expect(ids.toSet(), {'id1', 'id2'});
    },
  );

  test('getAllDatapointsInCategoryIterative returns datapoint nodes', () {
    final leafA = DatapointHierarchyNode(name: 'A', id: 'a');
    final leafB = DatapointHierarchyNode(name: 'B', id: 'b');
    final parent = DatapointHierarchyNode(name: 'P', children: [leafA, leafB]);

    final nodes = getAllDatapointsInCategoryIterative(parent);

    final ids = nodes.map((n) => n.id).toSet();
    expect(ids, {'a', 'b'});
    expect(nodes.length, 2);
  });

  test(
    'node with id and children includes both parent id and children ids',
    () {
      final child = DatapointHierarchyNode(name: 'child', id: 'c1');
      final parent = DatapointHierarchyNode(
        name: 'parent',
        id: 'p1',
        children: [child],
      );

      final ids = getAllDatapointIdsInCategoryIterative(parent);

      // iterative implementation adds both parent and child ids
      expect(ids.toSet(), {'p1', 'c1'});
    },
  );

  test('nodes with empty children return empty ids list', () {
    final node = DatapointHierarchyNode(name: 'empty', children: []);
    final ids = getAllDatapointIdsInCategoryIterative(node);
    expect(ids, isEmpty);

    final nodes = getAllDatapointsInCategoryIterative(node);
    expect(nodes, isEmpty);
  });

  test('deep tree traversal does not overflow and finds leaf id', () {
    // Build deep chain iteratively to avoid recursion during test construction
    const depth = 2000; // large but safe for iterative traversal
    var node = DatapointHierarchyNode(
      name: 'leaf',
      id: 'leaf_id',
    );
    for (var i = 0; i < depth; i++) {
      node = DatapointHierarchyNode(name: 'n_$i', children: [node]);
    }

    final ids = getAllDatapointIdsInCategoryIterative(node);
    expect(ids, contains('leaf_id'));
    expect(ids.length, 1);
  });
}
