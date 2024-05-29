import 'package:json_annotation/json_annotation.dart';

part 'coordinate.g.dart';

@JsonSerializable()
class Coordinate {
  const Coordinate({required this.x, required this.y});

  factory Coordinate.fromJson(Map<String, dynamic> json) => _$CoordinateFromJson(json);

  final int x;
  final int y;

  Map<String, dynamic> toJson() => _$CoordinateToJson(this);
}