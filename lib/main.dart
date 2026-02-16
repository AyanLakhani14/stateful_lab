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

  Color _counterColor() {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: Column(
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
                    if (_counter > 100) _counter = 100; // keep within slider max
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
        ],
      ),
    );
  }
}
