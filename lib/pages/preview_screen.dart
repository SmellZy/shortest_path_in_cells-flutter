import 'package:flutter/material.dart';
import 'package:graph_webspark/api/models/result_grid.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.grid});

  final ResultGrid grid;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.grid.field[0].length,
              ),
              itemCount:
                  (widget.grid.field.length * widget.grid.field[0].length)
                      .toInt(),
              itemBuilder: (context, index) {
                final x = (index % widget.grid.field[0].length).toInt();
                final y = (index ~/ widget.grid.field[0].length).toInt();
                final cell = widget.grid.grid.grid[y][x];
                final isPath = widget.grid.path.contains(cell);
                final isStart = widget.grid.start.x == cell.x &&
                    widget.grid.start.y == cell.y;
                final isEnd =
                    widget.grid.end.x == cell.x && widget.grid.end.y == cell.y;

                return Container(
                  margin: const EdgeInsets.all(1),
                  color: isStart
                      ? const Color(0xFF64FFDA)
                      : isEnd
                          ? const Color(0xFF009688)
                          : isPath
                              ? const Color(0xFF4CAF50)
                              : cell.isBlocked
                                  ? const Color(0xFF000000).withOpacity(0.7)
                                  : const Color(0xFFFFFFFF),
                  child: Center(
                    child: Text(
                      '(${cell.x},${cell.y})',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(widget.grid.pathString),
          ],
        ),
      ),
    );
  }
}
