import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('dadosArmazenados');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Exemplo de Aula',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hive CRUD',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DefineInstanciaPagina()));
              },
              child:
                  const Text('Entrar', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class DefineInstanciaPagina extends StatefulWidget {
  const DefineInstanciaPagina({super.key});

  @override
  createState() => HomePageState();
}

class HomePageState extends State<DefineInstanciaPagina> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final Box _dadosArmazenados = Hive.box('dadosArmazenados');
  int paginaIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    AddScreen(),
  ];
  List<String> _listaDadosArmazenamento = [];

  @override
  void initState() {
    super.initState();
    _carregaDados();
  }

  void _gravaDadosDispositivo() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String phone = _phoneController.text;
      String data = 'Nome: $name, Telefone: $phone';

      // Armazena os dados no Hive
      _dadosArmazenados.add(data);
      _nameController.clear();
      _phoneController.clear();

      _carregaDados();
    }
  }

  void _carregaDados() {
    setState(() {
      _listaDadosArmazenamento = List<String>.from(_dadosArmazenados.values);
    });
  }

  void _limpaAreaExibicao() {
    setState(() {
      _listaDadosArmazenamento.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            paginaIndex = index;
          });
        },
        indicatorColor: Colors.indigoAccent.shade400,
        selectedIndex: paginaIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: const Icon(Icons.add),
            label: 'Adicionar',
          ),
        ],
      ),
      body: _pages[paginaIndex],
    );
  }
}

class AddScreen extends StatefulWidget {
  AddScreen({super.key});

  @override
  createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final Box _dadosArmazenados = Hive.box('dadosArmazenados');

  @override
  void initState() {
    super.initState();
  }

  void _gravaDadosDispositivo() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String phone = _phoneController.text;
      String data = 'Nome: $name, Telefone: $phone';

      // Armazena os dados no Hive
      _dadosArmazenados.add(data);
      _nameController.clear();
      _phoneController.clear();
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um telefone';
              }
              return null;
            },
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar"),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildForm(),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _gravaDadosDispositivo,
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final Box _dadosArmazenados = Hive.box('dadosArmazenados');
  int paginaIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    AddScreen(),
  ];
  List<String> _listaDadosArmazenamento = [];

  @override
  void initState() {
    super.initState();
    _carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            paginaIndex = index;
          });
        },
        indicatorColor: Colors.indigoAccent.shade400,
        selectedIndex: paginaIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: const Icon(Icons.add),
            label: 'Adicionar',
          ),
        ],
      ),
      body: _pages[paginaIndex],
    );
  }
}
