import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_explore_mundo/main.dart';

void main() {
  testWidgets('Exibe título, abas e destinos', (WidgetTester tester) async {
    await tester.pumpWidget(const ExploreMundoApp());

    expect(find.text('Explore Mundo'), findsWidgets);
    expect(find.text('Destinos'), findsOneWidget);
    expect(find.text('Pacotes de viagem'), findsOneWidget);
    expect(find.text('Contato'), findsOneWidget);
    expect(find.text('Sobre nós'), findsOneWidget);

    // Encerra a árvore de widgets para cancelar o Timer do banner.
    await tester.pumpWidget(const SizedBox());
  });
}
