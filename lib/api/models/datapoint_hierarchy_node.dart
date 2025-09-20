import 'package:json_annotation/json_annotation.dart';

part 'datapoint_hierarchy_node.g.dart';

/// Represents a node in the hierarchical datapoint structure received from the API.
///
/// This class supports dynamic, project-specific hierarchies of varying depths where:
/// - **Categories/Subcategories**: Container nodes that group related items
/// - **Datapoints**: Leaf nodes with actual measurable data
///
/// ## Structure Assumptions (based on provided example):
///
/// **Category Node:**
/// ```dart
/// DatapointHierarchyNode(
///   name: "Production",           // User-friendly display name
///   children: [...]               // List of subcategories/datapoints
/// )
/// ```
///
/// **Subcategory Node:**
/// ```dart
/// DatapointHierarchyNode(
///   name: "Electrical production", // User-friendly display name
///   children: [...]                // List of further nested items
/// )
/// ```
///
/// **Datapoint Node (Leaf):**
/// ```dart
/// DatapointHierarchyNode(
///   name: "BHKW 1 electrical power",     // User-friendly display name
///   id: "CNV_1_CHP_1_ELCPOWEROUT"       // Technical identifier for API calls
/// )
/// ```
///
/// ## Expected API Response Format:
/// ```json
/// {
///   "datapoints": [
///     {
///       "name": "Production",
///       "children": [
///         {
///           "name": "Electrical production",
///           "children": [
///             {
///               "name": "BHKW 1 electrical power",
///               "id": "CNV_1_CHP_1_ELCPOWEROUT"
///             }
///           ]
///         }
///       ]
///     },
///     {
///       "name": "Consumption",
///       "children": [...]
///     }
///   ]
/// }
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class DatapointHierarchyNode {
  DatapointHierarchyNode({
    required this.name,
    this.id,
    this.children,
  });

  factory DatapointHierarchyNode.fromJson(Map<String, dynamic> json) =>
      _$DatapointHierarchyNodeFromJson(json);

  /// User-friendly display name
  final String name;

  /// Technical identifier - only present for actual datapoints
  final String? id;

  /// Child nodes - only present for categories
  final List<DatapointHierarchyNode>? children;

  /// Computed properties instead of stored booleans to help
  /// with UI logic
  bool get isDatapoint => id != null;

  bool get isCategory => children != null && children!.isNotEmpty;
}
