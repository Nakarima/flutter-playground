import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:developer' as developer;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'main.g.dart';

void main() => runApp(MyApp());

@swidget
Widget myApp(BuildContext context) {
  return MaterialApp(
    title: 'Hello',
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    home: HomePage('Hello', key: Key("homePage")),
  );
}

@hwidget
Widget homePage(String title) {
  final state = useStateWithLoggingAndDoubler(useContext(), 0);

  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: ListView(
      children: [
        Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${state.result}',
                style: Theme.of(useContext()).textTheme.headline4,
              ),
            ],
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: state.increment,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
}

class CounterState {
  final int result;
  final void Function() increment;
  final int doubled;

  CounterState(this.result, this.increment, this.doubled);
}

CounterState useStateWithLoggingAndDoubler(BuildContext context, int initialData) {
  final state = useState<int>(initialData);
  final doubled = initialData * 2;

  useEffect(() {
    developer.log("counter increased, value is: ${state.value}", name: "counter logger");
  }, [state.value]);

  return CounterState(state.value, () { state.value++; }, doubled);
}
