// Microatividade 5 - Widget Stack (empilhar widgets)
// Execute com: flutter run -t lib/microatividades/micro5.dart
import 'package:material_ui/material_ui.dart';

void main() => runApp(const Micro5App());

class Micro5App extends StatelessWidget {
  const Micro5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microatividade 5',
      home: Scaffold(
        appBar: AppBar(title: const Text('Stack')),
        body: Center(
          child: Stack(
            alignment: Alignment.center, // centraliza as camadas entre si
            children: [
              Container(
                width: 250,
                height: 250,
                color: Colors.blue,
              ),
              Container(
                width: 200,
                height: 200,
                color: Colors.red,
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
