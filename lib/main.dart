import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/pasien_page.dart';
import 'pages/perawat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoring Pasien',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const RoleSelectionPage(),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Peran'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoleCard(
                title: 'Pasien',
                icon: Icons.person,
                color: Colors.teal,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => const PasienPage(),
                  ));
                },
              ),
              const SizedBox(height: 20),
              RoleCard(
                title: 'Perawat',
                icon: Icons.medical_services,
                color: Colors.orange,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => const PerawatPage(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const RoleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
