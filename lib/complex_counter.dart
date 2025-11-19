import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:flutter_signals_tuto/signals/counter.dart';

class ComplexCounter extends HookWidget {
  final String title;
  const ComplexCounter({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Use useMemoized to persist signal instances across rebuilds
    final counter = useMemoized(() => CounterSignal());
    final counter2 = useMemoized(() => CounterSignal());
    // Create a signal for the sum that only updates when both counters change together
    final sumSignal = useMemoized(() => signal(counter.value + counter2.value));

    useSignalEffect(() {
      debugPrint(
        "This is signal Effect ::::: ${counter.value} ${counter2.value}",
      );
    });
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
                const Text('First Couter : '),
                Watch(
                  dependencies: [counter],
                  (_) => Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Second Couter : '),
                Watch(
                  dependencies: [counter2],
                  (_) => Text(
                    '${counter2.value}',
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
                  dependencies: [sumSignal],
                  (_) => Text(
                    '${sumSignal.value}',
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
              // instead of 3 times (once for counter, once for counter2, once for sumSignal)
              batch(() {
                counter.increment();
                counter2.increment();
                // Update sum only when both counters change together
                sumSignal.value = counter.value + counter2.value;
              });
              // Without batch: useSignalEffect would run 3 times
              // With batch: useSignalEffect runs only 1 time
            },
            tooltip: 'Increment Both',
            child: const Icon(Icons.add_box),
          ),
        ],
      ),
    );
  }
}
