import 'package:flutter/material.dart';
import 'package:graph_webspark/api/models/response_data/response_data.dart';
import 'package:graph_webspark/api/models/result_grid.dart';
import 'package:graph_webspark/pages/preview_screen.dart'; // Adjust the import as needed

class ResultsScreen extends StatelessWidget {
  final ResponseData data;
  final List<ResultGrid> grid;

  const ResultsScreen({super.key, required this.data, required this.grid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: ListView.builder(
        itemCount: data.data.length,
        itemBuilder: (context, index) {
          final item = data.data[index];
          return ListTile(
              title: Center(
                  child:
                      Text(grid[index].pathString)), // Adjust fields as needed
              subtitle: Text('Correct: ${item.correct}'),
              tileColor: item.correct ? Colors.green : Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewScreen(
                      grid: grid[index], // Pass the corresponding grid
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
