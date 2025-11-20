import 'package:flutter/material.dart';
import 'InheritedNotifier.dart';

class CounterInheritedNotifier extends InheritedNotifier<CounterModel> {
  const CounterInheritedNotifier({
    super.key,
    required CounterModel notifier,
    required super.child,
  }) : super(notifier: notifier);

  static CounterInheritedNotifier? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedNotifier>();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterModel _counterModel = CounterModel();

  @override
  Widget build(BuildContext context) {
    return CounterInheritedNotifier(
      notifier: _counterModel,
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = CounterInheritedNotifier.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedNotifier Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter!.notifier!.count}'),
            ElevatedButton(
              onPressed: counter.notifier!.increment,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}