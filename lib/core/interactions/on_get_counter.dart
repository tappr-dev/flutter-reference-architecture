import '../domain/counter.dart';
import '../infra/api_client.dart';

class OnGetCounter {
  final client = ApiClient();

  final OnGetCounterView view;

  OnGetCounter({required this.view});

  call() async {
    try {
      await view.showCounter(await client.getCounter());
    } catch (error) {
      await view.showGetCounterError(error);
    }
  }
}

abstract class OnGetCounterView {
  showCounter(Counter counter);

  showGetCounterError(Object error);
}
