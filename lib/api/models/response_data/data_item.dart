import 'package:json_annotation/json_annotation.dart';

part 'data_item.g.dart';

@JsonSerializable()
class DataItem {
  final String id;
  final bool correct;

  DataItem({
    required this.id,
    required this.correct,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) =>
      _$DataItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataItemToJson(this);
}