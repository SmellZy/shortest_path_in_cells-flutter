import 'dart:collection';

import 'package:graph_webspark/cell.dart';

class Grid {
  late List<List<Cell>> _grid;
  final int _width;
  final int _height;

  Grid(this._width, this._height) {
    _grid = List.generate(_height, (y) => List.generate(_width, (x) => Cell(x, y)));
  }

  bool isBlocked(int x, int y) {
    return _grid[y][x].isBlocked;
  }

  List<List<Cell>> get grid => _grid;

  List<Cell> getShortestPath(int startX, int startY, int endX, int endY) {
    Queue<List<Cell>> queue = Queue();
    List<Cell> currentPath = [_grid[startY][startX]];
    _grid[startY][startX].isVisited = true;
    queue.add(currentPath);

    while (queue.isNotEmpty) {
      currentPath = queue.removeFirst();
      Cell lastCell = currentPath.last;

      if (lastCell.x == endX && lastCell.y == endY) {
        return currentPath;
      }

      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx == 0 && dy == 0) continue;

          int x = lastCell.x + dx;
          int y = lastCell.y + dy;

          if (x >= 0 && x < _width && y >= 0 && y < _height && !isBlocked(x, y) && !_grid[y][x].isVisited) {
            List<Cell> newPath = List.from(currentPath);
            newPath.add(_grid[y][x]);
            _grid[y][x].isVisited = true;
            queue.add(newPath);
          }
        }
      }
    }

    return [];
  }
}