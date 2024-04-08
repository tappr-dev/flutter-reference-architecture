import '../domain/counter.dart';
import '../infra/api_client.dart';

class OnIncrementCounter {
  final client = ApiClient();

  final OnIncrementCounterView view;

  OnIncrementCounter({required this.view});

  call() async {
    try {
      await view.showCounter(await client.incrementCounter());
    } catch (error) {
      await view.showIncrementCounterError(error);
    }
  }
}

abstract class OnIncrementCounterView {
  showCounter(Counter counter);

  showIncrementCounterError(Object error);
}
