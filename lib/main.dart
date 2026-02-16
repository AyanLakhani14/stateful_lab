import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // STATE
  final TextEditingController _controller = TextEditingController();

  // BONUS: history for undo
  final List<int> _history = [];

  Color _counterColor() {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.black;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  void _saveHistory() {
    _history.add(_counter);
  }

  void _setCounter(int value) {
    // enforce range 0..100
    if (value > 100) {
      _showSnack("Limit Reached!");
      value = 100;
    }
    if (value < 0) value = 0;

    setState(() {
      _counter = value;
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() {
      _counter = _history.removeLast();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  color: Colors.blue.shade100,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '$_counter',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: _counterColor(),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Slider(
                min: 0,
                max: 100,
                value: _counter.toDouble(),
                onChanged: (double value) {
                  _saveHistory();
                  _setCounter(value.toInt());
                },
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _saveHistory();
                      _setCounter(_counter - 1);
                    },
                    child: Text("-1"),
                  ),

                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      _saveHistory();
                      _setCounter(_counter + 1);
                    },
                    child: Text("+1"),
                  ),

                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      _saveHistory();
                      _setCounter(0);
                    },
                    child: Text("Reset"),
                  ),

                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: _history.isEmpty ? null : _undo,
                    child: Text("Undo"),
                  ),
                ],
              ),

              SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter a number (0–100)",
                  ),
                ),
              ),

              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  final text = _controller.text.trim();
                  final value = int.tryParse(text);

                  if (value == null) {
                    _showSnack("Please enter a valid number.");
                    return;
                  }

                  _saveHistory();
                  _setCounter(value);
                },
                child: Text("Set Value"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
