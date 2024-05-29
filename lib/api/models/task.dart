import 'package:graph_webspark/api/models/coordinate.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  const Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  final String id;
  final List<String> field;
  final Coordinate start;
  final Coordinate end;

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}