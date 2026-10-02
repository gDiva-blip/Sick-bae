import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/symptom_provider.dart';
import 'screens/home_screen.dart';
import 'screens/get_help_screen.dart';

void main() {
  runApp(const SickBayApp());
}

class SickBayApp extends StatelessWidget {
  const SickBayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SymptomProvider()),
      ],
      child: MaterialApp(
        title: 'Sick Bay',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5BAFA3),
            primary: const Color(0xFF5BAFA3),
            secondary: const Color(0xFFFFB38A),
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF7FBFA),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF23413D),
            elevation: 0,
          ),
        ),
        home: const MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    GetHelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent_outlined),
            selectedIcon: Icon(Icons.support_agent),
            label: 'Get Help',
          ),
        ],
      ),
    );
  }
}