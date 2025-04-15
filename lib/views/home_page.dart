// lib/views/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore controller = Get.find();

  @override
  void initState() {
    super.initState();
    // Chama o método para buscar os dados quando o widget é inicializado
    controller.fetchCryptoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criptomoedas')),
      body: Column(
        children: [
          // Campo de busca
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar criptomoedas',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                controller.setSearchQuery(query);
              },
            ),
          ),
          // Lista de criptomoedas
          Expanded(
            child: Observer(
              builder: (_) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                final filteredList = controller.filteredCryptoList;
                if (filteredList.isEmpty) {
                  return Center(child: Text('Nenhuma criptomoeda encontrada'));
                }

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final crypto = filteredList[index];
                    return ListTile(
                      title: Text(crypto.name),
                      subtitle: Text(crypto.symbol),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}