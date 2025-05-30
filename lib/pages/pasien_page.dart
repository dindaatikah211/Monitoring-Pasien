import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({super.key});

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  final database = FirebaseDatabase.instance;

  Future<void> mintaBantuan(int id) async {
    final dbRef = database.ref("monitoring-pasien/pasien/0$id");

    final snapshot = await dbRef.get();
    int jumlah = 0;
    if (snapshot.exists && snapshot.child("jumlah_panggilan").value != null) {
      final value = snapshot.child("jumlah_panggilan").value;
      if (value is int) {
        jumlah = value;
      } else if (value is String) {
        jumlah = int.tryParse(value) ?? 0;
      }
    }

    await dbRef.update({
      "status": 1,
      "pesan": "Pasien $id meminta bantuan",
      "jumlah_panggilan": jumlah + 1,
      "sudah_direspon": false,
    });
  }

  Future<void> batalMinta(int id) async {
    final dbRef = database.ref("monitoring-pasien/pasien/0$id");
    await dbRef.update({
      "status": 0,
      "pesan": "Tidak ada permintaan bantuan",
      "sudah_direspon": false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Permintaan Pasien'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 2,
        itemBuilder: (context, index) {
          final id = index + 1;
          final pasienRef = database.ref("monitoring-pasien/pasien/0$id");

          return StreamBuilder<DatabaseEvent>(
            stream: pasienRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Terjadi kesalahan"));
              }

              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final rawData = snapshot.data!.snapshot.value as Map;
              final data = Map<String, dynamic>.from(rawData);

              final pesan = data["pesan"] ?? "-";
              final jumlah = data["jumlah_panggilan"] ?? 0;
              final sudahDirespon = data["sudah_direspon"] ?? false;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pasien 0$id",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text("Pesan: $pesan"),
                      Text("Jumlah panggilan: $jumlah"),
                      Text(
                        "Sudah direspon: ${sudahDirespon ? "Ya" : "Belum"}",
                        style: TextStyle(
                          color: sudahDirespon ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => mintaBantuan(id),
                            icon: const Icon(Icons.warning),
                            label: const Text("Minta Bantuan"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () => batalMinta(id),
                            icon: const Icon(Icons.cancel),
                            label: const Text("Batal"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[600],
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
