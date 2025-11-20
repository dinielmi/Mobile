import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: PokemonPage(),
    );
  }
}

class PokemonPage extends StatefulWidget {
  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  Map<String, dynamic>? _pokemonData;
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchPokemon() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/ditto'))
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        setState(() {
          _pokemonData = jsonDecode(response.body);
        });
      } else {
        setState(() {
          _error = 'Gagal memuat data. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Terjadi kesalahan: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPokemon(); // otomatis ambil data saat pertama kali
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!));
    }

    if (_pokemonData == null) {
      return Center(child: Text('Tidak ada data'));
    }

    final name = _pokemonData!['name'] ?? '-';
    final id = _pokemonData!['id'] ?? '-';
    final height = _pokemonData!['height'] ?? '-';
    final weight = _pokemonData!['weight'] ?? '-';
    final spriteUrl = _pokemonData!['sprites']?['front_default'] ?? 
        'https://via.placeholder.com/150';

    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(spriteUrl, width: 150, height: 150),
            SizedBox(height: 10),
            Text(
              name.toString().toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 8),
            Text('ID: $id'),
            Text('Tinggi: $height'),
            Text('Berat: $weight'),
            SizedBox(height: 10),
            if (_pokemonData!['types'] != null)
              Wrap(
                spacing: 8,
                children: (_pokemonData!['types'] as List)
                    .map<Widget>((type) => Chip(
                          label: Text(type['type']['name']),
                          backgroundColor: Colors.red[100],
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokémon Data")),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPokemon,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.red,
      ),
    );
  }
}