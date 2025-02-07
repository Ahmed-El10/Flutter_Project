import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
 @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(toggleTheme: _toggleTheme),
        '/details': (context) => DetailsScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Function(bool) toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;
  final TextEditingController _controller = TextEditingController();
  String _displayText = "";

  Future<String> _fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return "Hello from Future!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Features")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Dark Mode"),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
                widget.toggleTheme(value);
              },
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter Email"),
            ),
            SizedBox(height: 10),
          
             TextField(
              decoration: InputDecoration(labelText: "Enter password"),
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _displayText = _controller.text;
                });
              },
              child: Text("Show Text"),
            ),
            SizedBox(height: 10),
            Text(_displayText, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/details');
              },
              child: Text("Go to Details"),
            ),

            SizedBox(height: 20),
            FutureBuilder<String>(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error loading data");
                } else {
                  return Text(snapshot.data ?? "");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Center(
        child: Text("This is the details screen", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}