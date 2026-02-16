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
                  setState(() {
                    _counter = value.toInt();
                  });
                },
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_counter > 0) _counter--;
                      });
                    },
                    child: Text("-1"),
                  ),

                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter++;
                        if (_counter > 100) _counter = 100;
                      });
                    },
                    child: Text("+1"),
                  ),

                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                      });
                    },
                    child: Text("Reset"),
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

                  if (value > 100) {
                    _showSnack("Limit Reached!");
                    return;
                  }

                  if (value < 0) {
                    _showSnack("Value must be 0 or more.");
                    return;
                  }

                  setState(() {
                    _counter = value;
                  });
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
