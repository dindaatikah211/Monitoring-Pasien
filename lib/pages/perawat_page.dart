import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PerawatPage extends StatelessWidget {
  const PerawatPage({super.key});

  Stream<DatabaseEvent> getPasienData() {
    return FirebaseDatabase.instance.ref("monitoring-pasien/pasien").onValue;
  }

  Future<void> responPasien(String id) async {
    final ref = FirebaseDatabase.instance.ref("monitoring-pasien/pasien/$id");
    await ref.update({
      "status": 0,
      "pesan": "Sudah direspon perawat",
      "sudah_direspon": true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Pasien - Perawat'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: getPasienData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("Tidak ada data pasien."));
          }

          final data = Map<String, dynamic>.from(
            snapshot.data!.snapshot.value as Map,
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: data.entries.map((e) {
              final pasienId = e.key;
              final value = Map<String, dynamic>.from(e.value);

              final status = value['status'] ?? 0;
              final pesan = value['pesan'] ?? '-';
              final jumlah = value['jumlah_panggilan'] ?? 0;
              final sudahDirespon = value['sudah_direspon'] ?? false;

              final isActive = status == 1;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: isActive ? Colors.red[50] : Colors.green[50],
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isActive ? Icons.warning : Icons.check_circle,
                            color: isActive ? Colors.red : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Pasien $pasienId',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: (isActive && !sudahDirespon)
                              ? () => responPasien(pasienId)
                              : null,
                          icon: const Icon(Icons.check),
                          label: const Text("Sudah Direspon"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            disabledBackgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
