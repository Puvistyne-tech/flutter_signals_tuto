import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:flutter_signals_tuto/signals/counter.dart';

final StateCounterSignal counter = StateCounterSignal();
final StateCounterSignal counter2 = StateCounterSignal();
final StateCounterSignal sumSignal = StateCounterSignal();

class StatelessComplexCounter extends StatelessWidget {
  final String title;
  const StatelessComplexCounter({super.key, required this.title});
  // Create signals as instance variables to persist them across rebuilds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('First Counter : '),
                Watch(
                  dependencies: [counter.counter],
                  (_) => Text(
                    '${counter.getCounter()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Second Counter : '),
                Watch(
                  dependencies: [counter2.counter],
                  (_) => Text(
                    '${counter2.getCounter()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sum : '),
                Watch(
                  dependencies: [sumSignal.counter],
                  (_) => Text(
                    '${sumSignal.getCounter()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          FloatingActionButton(
            onPressed: counter.increment,
            tooltip: '1 ++',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: counter2.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add_business),
          ),
          FloatingActionButton(
            onPressed: () {
              // batch() is useful here to ensure the effect runs only ONCE
              // instead of multiple times (once for counter, once for counter2, once for sumSignal)
              batch(() {
                // counter.increment();
                // counter2.increment();
                // sumSignal will automatically update since it's computed from counter and counter2
                sumSignal.setValue(counter.getCounter() + counter2.getCounter());
              });
              // Without batch: effects would run multiple times
              // With batch: effects run only 1 time
            },
            tooltip: 'Increment Both',
            child: const Icon(Icons.add_box),
          ),
        ],
      ),
    );
  }
}
