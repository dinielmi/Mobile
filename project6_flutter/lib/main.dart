import 'package:flutter/material.dart';


//My Single-child Layout
void main() {
  runApp(MySingleChildApp());
}

class MySingleChildApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Single-child Layout')),
        body: Center(
          child: Text(
            'Hello Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

//My Multi-child Layout

//Column
void multichildColumn() => runApp(ColumnExample());

class ColumnExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Column Example')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Baris 1'),
            Text('Baris 2'),
            Text('Baris 3'),
          ],
        ),
      ),
    );
  }
}

//Row
void multichildRow() => runApp(RowExample());

class RowExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Row Example')),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.favorite, color: Colors.pink),
            Icon(Icons.settings, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

//Stack
void multichildStack() => runApp(StackExample());

class StackExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Stack Example')),
        body: Stack(
          children: [
            Container(color: Colors.blue, width: double.infinity, height: double.infinity),
            Align(
              alignment: Alignment.center,
              child: Icon(Icons.flutter_dash, size: 100, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

//ListView
void multichildListView() => runApp(ListViewExample());

class ListViewExample extends StatelessWidget {
  final List<String> items = ['Satu', 'Dua', 'Tiga', 'Empat', 'Lima'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ListView Example')),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.list),
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}


//GridView
void multichildGridView() => runApp(GridViewExample());

class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('GridView Example')),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return Card(
              color: Colors.amber,
              child: Center(
                child: Text('Item ${index + 1}', style: TextStyle(fontSize: 18)),
              ),
            );
          }),
        ),
      ),
    );
  }
}


//Styling and Positioning
void stylingPositioning() => runApp(StylingExample());

class StylingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Styling & Positioning')),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(2, 2)),
              ],
            ),
            child: Text(
              'Styled Container',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

//Navigation and Routing
void navigationRouting() => runApp(NavigationExample());

class NavigationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Utama')),
      body: Center(
        child: ElevatedButton(
          child: Text('Ke Halaman Kedua'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Kedua')),
      body: Center(
        child: ElevatedButton(
          child: Text('Kembali'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}



  

