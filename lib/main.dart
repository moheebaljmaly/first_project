import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حاسبة العمر',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'حاسبة العمر'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _birthDate;
  String _ageMessage = '';

  void _calculateAge() {
    if (_birthDate != null) {
      final today = DateTime.now();
      int age = today.year - _birthDate!.year;
      if (today.month < _birthDate!.month || (today.month == _birthDate!.month && today.day < _birthDate!.day)) {
        age--;
      }
      setState(() {
        _ageMessage = 'عمرك $age سنة.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('أدخل تاريخ ميلادك:'),
            TextField(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _birthDate = pickedDate;
                  });
                }
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: _birthDate == null ? 'اختر تاريخ' : _birthDate.toString().split(' ')[0],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _calculateAge,
                  child: const Text('احسب العمر'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _birthDate = null;
                      _ageMessage = '';
                    });
                  },
                  child: const Text('إعادة تعيين'),
                ),
              ],
            ),
            Text(
              _ageMessage,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
