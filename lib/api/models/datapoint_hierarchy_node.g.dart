// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datapoint_hierarchy_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatapointHierarchyNode _$DatapointHierarchyNodeFromJson(
  Map<String, dynamic> json,
) => DatapointHierarchyNode(
  name: json['name'] as String,
  id: json['id'] as String?,
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => DatapointHierarchyNode.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DatapointHierarchyNodeToJson(
  DatapointHierarchyNode instance,
) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
  'children': instance.children,
};
