import 'package:dio/dio.dart';
import 'package:graph_webspark/api/models/graph.dart';
import 'package:graph_webspark/api/models/post_data/request_data.dart';
import 'package:graph_webspark/api/models/response_data/response_data.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class GraphApiClient {
  factory GraphApiClient(Dio dio, {required String baseUrl}) = _GraphApiClient;

  factory GraphApiClient.create(String url) {
    final dio = Dio();
    return GraphApiClient(dio, baseUrl: url);
  }

  @GET('')
  Future<Graph> getGraph();

  @POST('')
  Future<ResponseData> postGraph(@Body() List<RequestData> data);
}