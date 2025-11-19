import 'package:signals_flutter/signals_flutter.dart';

class CounterSignal extends FlutterSignal<int> {
  CounterSignal() : super(0);

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }

  void reset() {
    value = 0;
  }

  void setValue(int value) {
    this.value = value;
  }
}

class StateCounterSignal {
  FlutterSignal<int> counter = signal(0);

  void increment() {
    counter.value++;
  }

  void decrement() {
    counter.value--;
  }

  void reset() {
    counter.value = 0;
  }

  void setValue(int value) {
    counter.value = value;
  }

  int getCounter() {
    return counter.value;
  }
}
