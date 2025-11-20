import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenceService();
  await prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProfilePage(),
    );
  }
}

class PreferenceService {
  static final PreferenceService _instance = PreferenceService._internal();
  factory PreferenceService() => _instance;
  PreferenceService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);
  int? getInt(String key) => _prefs.getInt(key);

  Future<bool> remove(String key) async => await _prefs.remove(key);
  Future<bool> clear() async => await _prefs.clear();
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PreferenceService _prefs = PreferenceService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _savedName;
  String? _savedEmail;
  String? _lastUpdated;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _saveUserData() async {
    await _prefs.setString('user_name', _nameController.text);
    await _prefs.setString('user_email', _emailController.text);
    await _prefs.setInt('last_update', DateTime.now().millisecondsSinceEpoch);

    await _loadUserData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully!')),
    );
  }

  Future<void> _loadUserData() async {
    setState(() {
      _nameController.text = _prefs.getString('user_name') ?? '';
      _emailController.text = _prefs.getString('user_email') ?? '';

      _savedName = _prefs.getString('user_name');
      _savedEmail = _prefs.getString('user_email');

      final lastUpdateMillis = _prefs.getInt('last_update');
      if (lastUpdateMillis != null) {
        final dt = DateTime.fromMillisecondsSinceEpoch(lastUpdateMillis);
        _lastUpdated = DateFormat('dd MMM yyyy, HH:mm').format(dt);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Input form
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveUserData,
              child: Text('Save'),
            ),
            SizedBox(height: 40),

            // Data yang disimpan
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Tersimpan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Nama: ${_savedName ?? "-"}"),
                  Text("Email: ${_savedEmail ?? "-"}"),
                  Text("Terakhir update: ${_lastUpdated ?? "-"}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}