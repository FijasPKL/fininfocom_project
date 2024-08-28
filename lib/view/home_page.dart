import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  NumberGrid createState() => NumberGrid();
}

class NumberGrid extends State<Homepage> {
  String selectedRule = 'Odd Numbers';
  List<int> _numbers = List.generate(100, (index) => index + 1);
  Set<int> _highlightedNumbers = {};

  @override
  void initState() {
    super.initState();
    rule_applying();
  }

  bool Fibonacci(int number) {
    int a = 0, b = 1;
    while (b < number) {
      int temp = a;
      a = b;
      b = temp + b;
    }
    return b == number || number == 0;
  }

  void rule_applying() {
    _highlightedNumbers.clear();
    for (int num in _numbers) {
      switch (selectedRule) {
        case 'Odd Numbers':
          if (num % 2 != 0) _highlightedNumbers.add(num);
          break;
        case 'Even Numbers':
          if (num % 2 == 0) _highlightedNumbers.add(num);
          break;
        case 'Prime Numbers':
          if (Prime(num)) _highlightedNumbers.add(num);
          break;
        case 'Fibonacci Numbers':
          if (Fibonacci(num)) _highlightedNumbers.add(num);
          break;
      }
    }
    setState(() {});
  }

  bool Prime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers Highlighter'),
        actions: [
          DropdownButton<String>(
            value: selectedRule,
            onChanged: (String? newValue) {
              setState(() {
                selectedRule = newValue!;
                rule_applying();
              });
            },
            items: <String>['Odd Numbers', 'Even Numbers', 'Prime Numbers', 'Fibonacci Numbers']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: _numbers.length,
        itemBuilder: (context, index) {
          int number = _numbers[index];
          bool isHighlighted = _highlightedNumbers.contains(number);
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isHighlighted ? Colors.orange : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 16,
                color: isHighlighted ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}

