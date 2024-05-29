import 'package:graph_webspark/api/models/post_data/result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_data.g.dart';

@JsonSerializable()
class RequestData {
  RequestData({
    required this.id,
    required this.result,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) =>
      _$RequestDataFromJson(json);

  final String id;
  final Result result;

  Map<String, dynamic> toJson() => _$RequestDataToJson(this);
}




