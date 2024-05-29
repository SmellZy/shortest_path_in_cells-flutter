class Cell {
  final int x;
  final int y;
  bool isBlocked;
  bool isVisited;

  Cell(this.x, this.y, {this.isBlocked = false, this.isVisited = false});
}