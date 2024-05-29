import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:graph_webspark/api/api.dart';
import 'package:graph_webspark/api/models/graph.dart';
import 'package:graph_webspark/api/models/response_data/response_data.dart';
import 'package:graph_webspark/bloc/graph_event.dart';
import 'package:graph_webspark/bloc/graph_state.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  GraphBloc() : super(GraphInitial()) {
    on<FetchGraphEvent>(_onFetchGraphEvent);
    on<PostGraphEvent>(_onPostGraphEvent); // Add handler for PostGraphEvent
  }

  Future<void> _onFetchGraphEvent(FetchGraphEvent event, Emitter<GraphState> emit) async {
    emit(GraphLoading(0.0));
    try {
      final GraphApiClient client = GraphApiClient.create(event.url);
      final Graph graph = await client.getGraph();
      emit(GraphLoaded(graph));
    } catch (e) {
      emit(GraphError(e.toString()));
    }
  }

  Future<void> _onPostGraphEvent(PostGraphEvent event, Emitter<GraphState> emit) async {
    emit(GraphLoading(0.0)); // Emit loading state before making the POST request
    try {
      final GraphApiClient client = GraphApiClient.create(event.url);
      // Assuming event.data contains the data to be posted
      final ResponseData response = await client.postGraph(event.data);
      // Handle the response as needed, for now, just emit a GraphLoaded state
      emit(GraphChecked(response));
    } catch (e) {
      emit(GraphError(e.toString())); // Emit error state if there's an exception
    }
  }
}
