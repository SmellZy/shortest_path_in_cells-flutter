import 'package:graph_webspark/cell.dart';
import 'package:graph_webspark/grid.dart';

class PathFinder {
  final Grid _grid;

  PathFinder(this._grid);

  List<Cell> findPath(int startX, int startY, int endX, int endY) {
    return _grid.getShortestPath(startX, startY, endX, endY);
  }
}