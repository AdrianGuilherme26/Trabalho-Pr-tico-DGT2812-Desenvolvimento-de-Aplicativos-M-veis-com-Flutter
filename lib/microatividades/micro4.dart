// Microatividade 4 - Widget ListView com ListTile
// Execute com: flutter run -t lib/microatividades/micro4.dart
import 'package:material_ui/material_ui.dart';

void main() => runApp(const Micro4App());

class Micro4App extends StatelessWidget {
  const Micro4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microatividade 4',
      home: Scaffold(
        appBar: AppBar(title: const Text('ListView')),
        body: ListView(
          children: [
            ListTile(
              title: Text('Flutter'),
              subtitle: Text('Tudo é um widget'),
              leading: Icon(Icons.flash_on),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: Text('Dart'),
              subtitle: Text('É fácil'),
              leading: Icon(Icons.mood),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: Text('Firebase'),
              subtitle: Text('Combina com Flutter'),
              leading: Icon(Icons.whatshot),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}
