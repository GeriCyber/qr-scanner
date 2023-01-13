import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/home.dart';
import 'package:qr_reader/screens/map.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
        theme: _buildThemeData(),
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeScreen(),
          'maps': (_) => MapScreen()
        },
      ),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.deepPurple.shade400,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple.shade500
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple.shade400,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.deepPurple.shade300),
        selectedItemColor: Colors.deepPurple.shade400
      )
    );
  }
}