import 'package:graph_webspark/api/models/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'graph.g.dart';

@JsonSerializable()
class Graph {
  const Graph({required this.data});

  factory Graph.fromJson(Map<String, dynamic> json) => _$GraphFromJson(json);

  final List<Task> data;

  Map<String, dynamic> toJson() => _$GraphToJson(this);
}