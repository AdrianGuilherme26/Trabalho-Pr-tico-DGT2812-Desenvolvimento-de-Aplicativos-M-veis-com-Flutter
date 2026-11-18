// Microatividade 3 - Layouts básicos com Row, Column, Icon e Text
// Execute com: flutter run -t lib/microatividades/micro3.dart
import 'package:material_ui/material_ui.dart';

void main() => runApp(const Micro3App());

class Micro3App extends StatelessWidget {
  const Micro3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microatividade 3',
      home: Scaffold(
        appBar: AppBar(title: const Text('Layouts com Row e Column')),
        body: Center(
          // Uma linha (Row) com três colunas (Column), cada uma com Icon + Text
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Icon(Icons.call), Text('Call')],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Icon(Icons.directions), Text('Route')],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Icon(Icons.share), Text('Share')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
