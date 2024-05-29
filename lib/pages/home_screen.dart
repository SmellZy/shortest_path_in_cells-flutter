import 'package:flutter/material.dart';
import 'package:graph_webspark/pages/process_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();
  final Future<String?> _controllerText = SharedPreferences.getInstance()
      .then((prefs) => prefs.getString('apiGet'));

  @override
  void initState() {
    super.initState();
    _controllerText.then((value) {
      if (value == null || value.isEmpty) {
        _urlController.text = '';
      } else {
        _urlController.text = value;
      }
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home screen'),
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: deviceWidth,
              height: deviceHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Set valid API base URL in order to continue",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    const Icon(Icons.compare_arrows),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          labelText: 'API URL',
                        ),
                      ),
                    ),
                  ]),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),),
                    onPressed: () {
                      SharedPreferences.getInstance().then((prefs) =>
                          prefs.setString('apiGet', _urlController.text));
                      //_graphBloc.add(FetchGraphEvent(_urlController.text));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProcessScreen(
                                    apiUrl: _urlController.text,
                                  )));
                    },
                    child: const Text("Start counting process"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
