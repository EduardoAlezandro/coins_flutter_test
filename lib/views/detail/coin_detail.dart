import 'package:coins_flutter_test/models/coins/coins_detail_model.dart';
import 'package:coins_flutter_test/stores/detail/coin_detail_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CoinDetailScreen extends GetView<CoinDetailStore> {
  final String coinId;

  const CoinDetailScreen({super.key, required this.coinId});

  @override
  Widget build(BuildContext context) {
    // Inicializa a store com o ID da moeda
    Get.put(CoinDetailStore()).fetchCoinDetails(coinId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Moeda'),
      ),
      body: Observer(
        builder: (_) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error.isNotEmpty) {
            return Center(child: Text(controller.error));
          }
          if (controller.coin == null) {
            return const Center(child: Text('Moeda não encontrada'));
          }

          final coin = controller.coin!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(coin),
                  const SizedBox(height: 16),
                  _buildPriceInfo(coin),
                  const SizedBox(height: 16),
                  _buildMarketData(coin),
                  const SizedBox(height: 16),
                  _buildDescription(coin),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(CoinDetailModel coin) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(coin.symbol.toUpperCase()),
        ),
        const SizedBox(width: 8),
        Text(
          coin.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPriceInfo(CoinDetailModel coin) {
    final isPositive = (coin.priceChangePercentage24h ?? 0) >= 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${coin.currentPriceUsd?.toStringAsFixed(2) ?? 'N/A'}',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isPositive ? Colors.green[100] : Colors.red[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${coin.priceChangePercentage24h?.toStringAsFixed(1) ?? 'N/A'}%',
            style: TextStyle(
              color: isPositive ? Colors.green[800] : Colors.red[800],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketData(CoinDetailModel coin) {
    final format = NumberFormat.compact(locale: 'en_US');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Capitalização de Mercado', style: TextStyle(color: Colors.grey[600])),
        Text('\$${format.format(coin.marketCapUsd)}'),
        const SizedBox(height: 8),
        Text('Volume (24h)', style: TextStyle(color: Colors.grey[600])),
        Text('\$${format.format(coin.totalVolumeUsd)}'),
      ],
    );
  }

  Widget _buildDescription(CoinDetailModel coin) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Descrição', style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 8),
        Text(
          coin.description ?? 'Sem descrição disponível.',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}