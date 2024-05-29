// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Graph _$GraphFromJson(Map<String, dynamic> json) => Graph(
      data: (json['data'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GraphToJson(Graph instance) => <String, dynamic>{
      'data': instance.data,
    };
