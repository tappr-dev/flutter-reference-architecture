import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/domain/counter.dart';
import '../../core/interactions/on_get_counter.dart';
import '../../core/interactions/on_increment_counter.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    implements OnGetCounterView, OnIncrementCounterView {
  _HomeState() {
    onGetCounter = OnGetCounter(view: this);
    onIncrementCounter = OnIncrementCounter(view: this);
  }

  final dateFormatter = DateFormat.yMd().add_jm();

  late OnGetCounter onGetCounter;
  late OnIncrementCounter onIncrementCounter;

  Counter? _counter;
  Object? _error;

  @override
  void initState() {
    super.initState();

    onGetCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(child: _bodyContent),
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  Widget get _bodyContent {
    if (_isLoading) return const CircularProgressIndicator();

    if (_error != null) {
      return GestureDetector(
        onTap: () {
          setState(() => _error = null);
          onGetCounter();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Failed to get counter: $_error.'),
            const Text('Please, tap here to retry...')
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('The button has been pushed this many times:'),
        Text(
          '${_counter!.value}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
            'Last time was pressed on ${dateFormatter.format(_counter!.updatedAt)}'),
      ],
    );
  }

  FloatingActionButton? get _floatingActionButton {
    return _error == null
        ? FloatingActionButton(
            onPressed: _counter != null
                ? () {
                    setState(() => _counter = null);
                    onIncrementCounter();
                  }
                : null,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        : null;
  }

  bool get _isLoading => _counter == null && _error == null;

  @override
  showCounter(Counter counter) {
    if (!mounted) return;
    setState(() {
      _counter = counter;
      _error = null;
    });
  }

  @override
  showGetCounterError(Object error) => _showCounterError(error);

  @override
  showIncrementCounterError(Object error) {
    _showCounterError(error);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Failed to increment counter: $error. Please, retry...'),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  _showCounterError(Object error) {
    if (!mounted) return;
    setState(() {
      _counter = null;
      _error = error;
    });
  }
}
