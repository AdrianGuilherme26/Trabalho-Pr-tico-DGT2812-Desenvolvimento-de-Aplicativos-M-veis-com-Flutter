// Microatividade 2 - MaterialApp, Scaffold e AppBar
// Execute com: flutter run -t lib/microatividades/micro2.dart
import 'package:material_ui/material_ui.dart';

void main() {
  return runApp(
    MaterialApp(
      home: StatelessWidgetExemplo("Olá Flutter - MaterialApp"),
    ),
  );
}

class StatelessWidgetExemplo extends StatelessWidget {
  final String _appBarTitle;

  StatelessWidgetExemplo(this._appBarTitle) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Center(
        child: Text('Macoratti .net'),
      ),
    );
  }
}
