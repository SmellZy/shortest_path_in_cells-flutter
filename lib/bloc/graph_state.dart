import 'package:graph_webspark/api/models/graph.dart';
import 'package:graph_webspark/api/models/response_data/response_data.dart';

abstract class GraphState {}

class GraphInitial extends GraphState {}

class GraphLoading extends GraphState {
  final double progress;

  GraphLoading(this.progress);
}

class GraphLoaded extends GraphState {
  final Graph graph;

  GraphLoaded(this.graph);
}

class GraphChecked extends GraphState{
  final ResponseData response;

  GraphChecked(this.response);
}

class GraphError extends GraphState {
  final String message;

  GraphError(this.message);
}