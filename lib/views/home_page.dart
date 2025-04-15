import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/home_store.dart';

class HomePage extends GetView<HomeStore> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criptomoedas')),
      body: Column(
        children: [
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
          Expanded(
            child: Observer(
              builder: (_) {
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
                      subtitle: Text(
                        '${crypto.symbol} - \$${crypto.price.toStringAsFixed(2)}',
                      ),
                      trailing: Text(
                        '${crypto.percentChange.toStringAsFixed(2)}%',
                        style: TextStyle(
                          color:
                              crypto.percentChange >= 0
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ),
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
