import 'package:graph_webspark/api/models/post_data/cell_step.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  Result({
    required this.steps,
    required this.path,
  });

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  final List<CellStep> steps;
  final String path;

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}