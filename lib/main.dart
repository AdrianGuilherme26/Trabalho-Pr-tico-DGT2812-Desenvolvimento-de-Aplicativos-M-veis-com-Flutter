// Trabalho Prático DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter
// App "Explore Mundo" - Agência de Viagens
import 'dart:async';

import 'package:material_ui/material_ui.dart';

void main() => runApp(const ExploreMundoApp());

// ---------------------------------------------------------------------------
// MODELOS E DADOS
// ---------------------------------------------------------------------------

class Destino {
  final String nome;
  final String local;
  final double nota;
  final int avaliacoes;
  final String imagem;
  final String descricao;

  const Destino({
    required this.nome,
    required this.local,
    required this.nota,
    required this.avaliacoes,
    required this.imagem,
    required this.descricao,
  });
}

class Pacote {
  final String titulo;
  final String descricao;
  final String preco;
  final IconData icone;

  const Pacote({
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.icone,
  });
}

const List<Destino> destinos = [
  Destino(
    nome: 'Fernando de Noronha',
    local: 'Pernambuco, Brasil',
    nota: 4.9,
    avaliacoes: 312,
    imagem: 'images/noronha.jpg',
    descricao: 'Arquipélago de águas cristalinas, ideal para mergulho, '
        'snorkel e trilhas com vistas incríveis. Um dos destinos de '
        'natureza mais procurados do país, com praias de tirar o fôlego '
        'e vida marinha abundante.',
  ),
  Destino(
    nome: 'Bonito',
    local: 'Mato Grosso do Sul, Brasil',
    nota: 4.8,
    avaliacoes: 287,
    imagem: 'images/bonito.jpg',
    descricao: 'Capital do ecoturismo, famosa por rios de águas '
        'transparentes, flutuação, cachoeiras e grutas. Perfeita para '
        'quem busca aventura e contato com a natureza.',
  ),
  Destino(
    nome: 'Lençóis Maranhenses',
    local: 'Maranhão, Brasil',
    nota: 4.8,
    avaliacoes: 256,
    imagem: 'images/lencois.jpg',
    descricao: 'Imensas dunas de areia branca intercaladas por lagoas de '
        'água da chuva. Passeios de buggy, caminhadas e banhos de lagoa '
        'em um cenário único no mundo.',
  ),
  Destino(
    nome: 'Foz do Iguaçu',
    local: 'Paraná, Brasil',
    nota: 4.7,
    avaliacoes: 341,
    imagem: 'images/foz.jpg',
    descricao: 'Lar das Cataratas do Iguaçu, um dos cenários naturais mais '
        'impressionantes da América do Sul. Passeios de barco, trilhas e '
        'visitas ao lado argentino completam o roteiro.',
  ),
];

const List<Pacote> pacotes = [
  Pacote(
    titulo: 'Noronha Essencial - 5 noites',
    descricao: 'Aéreo, hospedagem, traslados e passeio de barco',
    preco: 'R\$ 4.890',
    icone: Icons.beach_access,
  ),
  Pacote(
    titulo: 'Bonito Aventura - 4 noites',
    descricao: 'Hospedagem, flutuação no rio e visita às grutas',
    preco: 'R\$ 3.250',
    icone: Icons.water,
  ),
  Pacote(
    titulo: 'Lençóis Maranhenses - 4 noites',
    descricao: 'Voo, passeio de buggy e banho nas lagoas',
    preco: 'R\$ 3.780',
    icone: Icons.terrain,
  ),
  Pacote(
    titulo: 'Cataratas do Iguaçu - 3 noites',
    descricao: 'Hospedagem, ingressos do parque e passeio de barco',
    preco: 'R\$ 2.490',
    icone: Icons.landscape,
  ),
  Pacote(
    titulo: 'Pacote Família - 7 noites',
    descricao: 'Roteiro flexível com atividades para todas as idades',
    preco: 'R\$ 7.900',
    icone: Icons.family_restroom,
  ),
];

// ---------------------------------------------------------------------------
// FUNÇÕES AUXILIARES
// ---------------------------------------------------------------------------

/// Remove acentos e converte para minúsculas, para que a pesquisa
/// encontre "Lençóis" ao digitar "lencois".
String normalizar(String texto) {
  const de = 'áàâãäéèêëíìîïóòôõöúùûüç';
  const para = 'aaaaaeeeeiiiiooooouuuuc';
  var resultado = texto.toLowerCase();
  for (var i = 0; i < de.length; i++) {
    resultado = resultado.replaceAll(de[i], para[i]);
  }
  return resultado;
}

/// Pede confirmação e registra a reserva (simulada).
Future<void> confirmarReserva(BuildContext context, String item) async {
  final confirmou = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Confirmar reserva'),
      content: Text('Deseja reservar "$item"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Confirmar'),
        ),
      ],
    ),
  );
  if (confirmou == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reserva de "$item" solicitada! Entraremos em contato.'),
      ),
    );
  }
}

/// Abre um diálogo para o cliente escrever uma mensagem à agência.
Future<void> enviarMensagem(BuildContext context) async {
  var texto = '';
  final enviar = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Enviar mensagem'),
      content: TextField(
        maxLines: 4,
        onChanged: (valor) => texto = valor,
        decoration: const InputDecoration(
          hintText: 'Escreva sua mensagem para a equipe',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Enviar'),
        ),
      ],
    ),
  );
  if (enviar == true && context.mounted) {
    final vazio = texto.trim().isEmpty;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(vazio
            ? 'Escreva uma mensagem antes de enviar.'
            : 'Mensagem enviada! Responderemos em breve.'),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// APLICATIVO
// ---------------------------------------------------------------------------

class ExploreMundoApp extends StatelessWidget {
  const ExploreMundoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ---------------------------------------------------------------------------
// TELA INICIAL: barra de navegação, pesquisa rápida e seções
// ---------------------------------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _busca = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _busca.dispose();
    super.dispose();
  }

  bool _combina(String texto) {
    final termo = normalizar(_query.trim());
    return termo.isEmpty || normalizar(texto).contains(termo);
  }

  void _abrirDestino(Destino destino) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DestinoPage(destino: destino)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Barra de navegação: abas "Destinos", "Pacotes de viagem",
    // "Contato" e "Sobre nós".
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explore Mundo'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.place), text: 'Destinos'),
              Tab(icon: Icon(Icons.card_travel), text: 'Pacotes de viagem'),
              Tab(icon: Icon(Icons.phone), text: 'Contato'),
              Tab(icon: Icon(Icons.info), text: 'Sobre nós'),
            ],
          ),
        ),
        body: Column(
          children: [
            _buildBusca(),
            Expanded(
              child: TabBarView(
                children: [
                  _abaDestinos(),
                  _abaPacotes(),
                  _abaContato(),
                  _abaSobre(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Pesquisa rápida ------------------------------------------------------
  Widget _buildBusca() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        controller: _busca,
        onChanged: (valor) => setState(() => _query = valor),
        decoration: InputDecoration(
          hintText: 'Pesquisar destinos ou pacotes...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _busca.clear();
                    setState(() => _query = '');
                  },
                ),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  // --- Aba Destinos: banner + lista de destinos ------------------------------
  Widget _abaDestinos() {
    final lista = destinos
        .where((d) => _combina('${d.nome} ${d.local} ${d.descricao}'))
        .toList();
    return ListView(
      children: [
        if (_query.trim().isEmpty)
          BannerDestaque(itens: destinos, aoTocar: _abrirDestino),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Destinos em destaque',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        if (lista.isEmpty) const _SemResultados() else ...lista.map(_cardDestino),
      ],
    );
  }

  Widget _cardDestino(Destino d) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _abrirDestino(d),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              d.imagem,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(
                d.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(d.local),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber[700]),
                  const SizedBox(width: 4),
                  Text(d.nota.toStringAsFixed(1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Aba Pacotes de viagem: ListView + ListTile ---------------------------
  Widget _abaPacotes() {
    final lista =
        pacotes.where((p) => _combina('${p.titulo} ${p.descricao}')).toList();
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Pacotes de viagem',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        if (lista.isEmpty)
          const _SemResultados()
        else
          ...lista.map(
            (p) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(child: Icon(p.icone)),
                title: Text(p.titulo),
                subtitle: Text(p.descricao),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      p.preco,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.keyboard_arrow_right),
                  ],
                ),
                onTap: () => confirmarReserva(context, p.titulo),
              ),
            ),
          ),
      ],
    );
  }

  // --- Aba Contato ----------------------------------------------------------
  Widget _abaContato() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Fale com a nossa equipe',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.phone),
          title: Text('Telefone'),
          subtitle: Text('(00) 0000-0000'),
        ),
        const ListTile(
          leading: Icon(Icons.chat),
          title: Text('WhatsApp'),
          subtitle: Text('(00) 00000-0000'),
        ),
        const ListTile(
          leading: Icon(Icons.email),
          title: Text('E-mail'),
          subtitle: Text('contato@exploremundo.com.br'),
        ),
        const ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Endereço'),
          subtitle: Text('Rua das Viagens, 100 - Centro'),
        ),
        const ListTile(
          leading: Icon(Icons.schedule),
          title: Text('Atendimento'),
          subtitle: Text('Segunda a sexta, das 8h às 18h'),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () => enviarMensagem(context),
            icon: const Icon(Icons.send),
            label: const Text('Enviar mensagem'),
          ),
        ),
      ],
    );
  }

  // --- Aba Sobre nós: usa Stack para sobrepor widgets -----------------------
  Widget _abaSobre() {
    return ListView(
      children: [
        SizedBox(
          height: 180,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade700, Colors.teal.shade300],
                  ),
                ),
              ),
              const Positioned(
                right: -20,
                bottom: -20,
                child: Icon(Icons.public, size: 170, color: Colors.white24),
              ),
              const Positioned(
                left: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Mundo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sua próxima viagem começa aqui',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          child: const Text(
            'A Explore Mundo é uma agência de viagens dedicada a transformar '
            'sonhos em experiências inesquecíveis. Montamos roteiros '
            'personalizados, cuidamos de passagens, hospedagem e passeios, e '
            'acompanhamos você em cada etapa da viagem.',
            softWrap: true,
          ),
        ),
        const ListTile(
          leading: Icon(Icons.flag),
          title: Text('Missão'),
          subtitle: Text('Conectar pessoas a destinos que inspiram.'),
        ),
        const ListTile(
          leading: Icon(Icons.visibility),
          title: Text('Visão'),
          subtitle: Text('Ser referência em viagens personalizadas.'),
        ),
        const ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Valores'),
          subtitle: Text('Transparência, cuidado e respeito ao meio ambiente.'),
        ),
      ],
    );
  }
}

class _SemResultados extends StatelessWidget {
  const _SemResultados();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(child: Text('Nenhum resultado encontrado.')),
    );
  }
}

// ---------------------------------------------------------------------------
// BANNER DE DESTAQUE: slideshow interativo (toque abre o destino)
// ---------------------------------------------------------------------------

class BannerDestaque extends StatefulWidget {
  final List<Destino> itens;
  final ValueChanged<Destino> aoTocar;

  const BannerDestaque({super.key, required this.itens, required this.aoTocar});

  @override
  State<BannerDestaque> createState() => _BannerDestaqueState();
}

class _BannerDestaqueState extends State<BannerDestaque> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _atual = 0;

  @override
  void initState() {
    super.initState();
    // Troca de imagem automaticamente a cada 4 segundos.
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final proximo = (_atual + 1) % widget.itens.length;
      _controller.animateToPage(
        proximo,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.itens.length,
            onPageChanged: (i) => setState(() => _atual = i),
            itemBuilder: (context, i) {
              final d = widget.itens[i];
              return GestureDetector(
                onTap: () => widget.aoTocar(d),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(d.imagem, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 32,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.nome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            d.local,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.itens.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _atual ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _atual ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PÁGINA DO DESTINO: segue o layout do roteiro (imagem, título, botões, texto)
// ---------------------------------------------------------------------------

class DestinoPage extends StatelessWidget {
  final Destino destino;

  const DestinoPage({super.key, required this.destino});

  void _aviso(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  // Passo 6: método auxiliar que gera cada coluna de botão (Icon + Text).
  Widget _buildButtonColumn(
    Color color,
    IconData icon,
    String label,
    VoidCallback aoTocar,
  ) {
    return InkWell(
      onTap: aoTocar,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Passo 5: seção de título (coluna de textos + estrela + nota).
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    destino.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  destino.local,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          Text(
            '${destino.nota.toStringAsFixed(1)} (${destino.avaliacoes})',
          ),
        ],
      ),
    );

    // Passo 6: seção de botões (CALL, ROUTE, SHARE).
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL',
            () => _aviso(context, 'Ligando para a Explore Mundo...')),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE',
            () => _aviso(context, 'Abrindo rota até ${destino.nome}...')),
        _buildButtonColumn(color, Icons.share, 'SHARE',
            () => _aviso(context, 'Compartilhando ${destino.nome}...')),
      ],
    );

    // Passo 7: seção de texto.
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(destino.descricao, softWrap: true),
    );

    // Botão de reserva.
    Widget reservaSection = Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: ElevatedButton.icon(
        onPressed: () => confirmarReserva(context, destino.nome),
        icon: const Icon(Icons.flight_takeoff),
        label: const Text('Reservar viagem'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(destino.nome),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // Passo 9: ListView no lugar de Column para permitir rolagem.
      body: ListView(
        children: [
          // Passo 8: imagem carregada do diretório images/.
          Image.asset(
            destino.imagem,
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection,
          reservaSection,
        ],
      ),
    );
  }
}
