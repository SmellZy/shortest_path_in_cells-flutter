import 'package:equatable/equatable.dart';
import 'package:graph_webspark/api/models/post_data/request_data.dart';

abstract class GraphEvent extends Equatable {
  const GraphEvent();

  @override
  List<Object?> get props => [];
}

class FetchGraphEvent extends GraphEvent {
  final String url;

  FetchGraphEvent(this.url);

  @override
  List<Object?> get props => [url];
}

class PostGraphEvent extends GraphEvent {
  final String url;
  final List<RequestData> data;

  PostGraphEvent(this.url, this.data);

  @override
  List<Object?> get props => [url, data];
}
