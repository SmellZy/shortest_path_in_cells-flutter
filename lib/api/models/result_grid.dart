import 'package:graph_webspark/api/models/coordinate.dart';
import 'package:graph_webspark/cell.dart';
import 'package:graph_webspark/grid.dart';

class ResultGrid{
  final String id;
  final List field;
  final Grid grid;
  final List<Cell> path;
  final String pathString;
  final Coordinate start;
  final Coordinate end;

  ResultGrid({required this.pathString, required this.id, required this.field, required this.grid, required this.path, required this.start, required this.end});
}