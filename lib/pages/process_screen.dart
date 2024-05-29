import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_webspark/api/models/post_data/cell_step.dart';
import 'package:graph_webspark/api/models/post_data/request_data.dart';
import 'package:graph_webspark/api/models/post_data/result.dart';
import 'package:graph_webspark/api/models/result_grid.dart';
import 'package:graph_webspark/bloc/graph_bloc.dart';
import 'package:graph_webspark/bloc/graph_event.dart';
import 'package:graph_webspark/bloc/graph_state.dart';
import 'package:graph_webspark/grid.dart';
import 'package:graph_webspark/pages/result_screen.dart';
import 'package:graph_webspark/path.dart';

class ProcessScreen extends StatefulWidget {
  ProcessScreen({super.key, required this.apiUrl});

  String apiUrl;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  late GraphBloc _graphBloc;
  List<ResultGrid> resultGrid = [];
  List<RequestData> requestData = [];

  void initState() {
    super.initState();
    _graphBloc = GraphBloc();
    _graphBloc.add(FetchGraphEvent(widget.apiUrl));
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => _graphBloc,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Process screen'),
            backgroundColor: Colors.blue,
          ),
          body: BlocBuilder<GraphBloc, GraphState>(
            builder: (context, state) {
              
              if (state is GraphLoaded) {
                for (int i = 0; i < state.graph.data.length; i++) {
                  final task = state.graph.data[i];
                  final start = task.start;
                  final end = task.end;
                  final field = task.field;

                  final grid = Grid(field[0].length, field.length);
                  for (int y = 0; y < field.length; y++) {
                    for (int x = 0; x < field[y].length; x++) {
                      grid.grid[y][x].isBlocked = field[y][x] == 'X';
                    }
                  }

                  final pathFinder = PathFinder(grid);
                  final path =
                      pathFinder.findPath(start.x, start.y, end.x, end.y);
                  final pathString =
                      path.map((cell) => '(${cell.x},${cell.y})').join('->');

                  List<CellStep> steps = path
                      .map((cell) =>
                          CellStep(x: cell.x.toString(), y: cell.y.toString()))
                      .toList();

                  resultGrid.add(ResultGrid(
                      id: state.graph.data[i].id,
                      field: field,
                      grid: grid,
                      path: path,
                      pathString: pathString,
                      start: start,
                      end: end));

                  for (final item in resultGrid) {
                    print(item.id);
                  }

                  requestData.add(RequestData(
                      id: state.graph.data[i].id,
                      result: Result(steps: steps, path: pathString)));
                }
                return Center(
                    child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      width: deviceWidth,
                      height: deviceHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "All calculations has finished, you can send your results to server",
                                      style: TextStyle(fontSize: 24),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Text("100%", style: TextStyle(fontSize: 28)),
                              SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5,
                                  )),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                fixedSize: Size(deviceWidth * 0.8, 40)),
                            onPressed: () {
                              _graphBloc.add(
                                  PostGraphEvent(widget.apiUrl, requestData));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProcessScreen()));
                            },
                            child: const Text("Send results to server"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
              } else if (state is GraphChecked) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultsScreen(data: state.response, grid: resultGrid),
                    ),
                  );
                });
                return const SizedBox();
              }
              else if (state is GraphError) {
                    Navigator.of(context).pop();
              } else {
                return InitialWidget(
                    deviceWidth: deviceWidth, 
                    deviceHeight: deviceHeight,
                    );
              }
              return const SizedBox();
            },
          )),
    );
  }
}


class InitialWidget extends StatefulWidget {
  const InitialWidget({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
  });

  final double deviceWidth;
  final double deviceHeight;

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  double progress = 0.0;
  void increaseProgress() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        progress += 1.0;
        if (progress >= 100) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: widget.deviceWidth,
          height: widget.deviceHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    "Calculating...",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "${(progress).toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 28),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      value: progress
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
