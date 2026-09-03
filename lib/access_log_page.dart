import 'package:flutter/material.dart';
import '../models/access_record.dart';
import '../services/access_log_service.dart';

class AccessLogPage extends StatelessWidget {
  const AccessLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitácora de accesos'),
      ),
      body: logService.records.isEmpty
          ? const Center(
              child: Text(
                'No hay registros de acceso.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: logService.records.length,
              itemBuilder: (context, index) {
                final AccessRecord registro =
                    logService.records[index];

                return ListTile(
                  leading: Icon(
                    registro.exitoso
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: registro.exitoso
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(
                    registro.usuario.isEmpty
                        ? '(sin usuario)'
                        : registro.usuario,
                  ),
                  subtitle: Text(
                    registro.fechaHora.toString(),
                  ),
                  trailing: Text(
                    registro.exitoso ? 'OK' : 'FALLÓ',
                    style: TextStyle(
                      color: registro.exitoso
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
    );
  }
}