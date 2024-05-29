import 'package:json_annotation/json_annotation.dart';

part 'cell_step.g.dart';

@JsonSerializable()
class CellStep {
  CellStep({
    required this.x,
    required this.y,
  });

  factory CellStep.fromJson(Map<String, dynamic> json) => _$CellStepFromJson(json);

  final String x;
  final String y;

  Map<String, dynamic> toJson() => _$CellStepToJson(this);
}