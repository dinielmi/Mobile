import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WireMockApp());
}

class WireMockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WireMock Cloud Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: UserPage(),
    );
  }
}

class ApiConfig {
  static const String baseUrl = 'https://your-wiremock-cloud-instance.wiremockapi.cloud';
  static const String usersEndpoint = '/users';
  static const int timeoutSeconds = 30;

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<dynamic> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _postMessage;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  /// GET users
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.usersEndpoint}');

    try {
      final response = await http
          .get(url, headers: ApiConfig.headers)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() => _users = data);
      } else {
        setState(() => _errorMessage = 'Error ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// POST user
  Future<void> _addUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nama & Email harus diisi')),
      );
      return;
    }

    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.usersEndpoint}');
    final body = jsonEncode({'name': name, 'email': email});

    try {
      final response = await http
          .post(url, headers: ApiConfig.headers, body: body)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);

        setState(() {
          _postMessage = result['message'] ?? 'User berhasil ditambahkan';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_postMessage!)),
        );

        _nameController.clear();
        _emailController.clear();
        _fetchUsers();
      } else {
        setState(() => _postMessage = 'Gagal menambah user (${response.statusCode})');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_postMessage!)),
        );
      }
    } catch (e) {
      setState(() => _postMessage = 'Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_postMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WireMock Cloud - Users")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input form
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Tambah User"),
              onPressed: _addUser,
            ),
            SizedBox(height: 20),

            if (_postMessage != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _postMessage!,
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: 20),

            Text(
              'Daftar User',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Divider(),

            // Data List
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(child: Text(_errorMessage!))
                      : _users.isEmpty
                          ? Center(child: Text('Belum ada data.'))
                          : ListView.builder(
                              itemCount: _users.length,
                              itemBuilder: (context, index) {
                                final user = _users[index];
                                return ListTile(
                                  leading: CircleAvatar(child: Text('${user['id'] ?? '?'}')),
                                  title: Text(user['name'] ?? ''),
                                  subtitle: Text(user['email'] ?? ''),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchUsers,
        child: Icon(Icons.refresh),
      ),
    );
  }
}