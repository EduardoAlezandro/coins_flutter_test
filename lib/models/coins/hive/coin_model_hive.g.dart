// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoinModelHiveAdapter extends TypeAdapter<CoinModelHive> {
  @override
  final int typeId = 0;

  @override
  CoinModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoinModelHive(
      id: fields[0] as String,
      symbol: fields[1] as String,
      name: fields[2] as String,
      platforms: (fields[3] as Map?)?.cast<String, dynamic>(),
      currentPrice: fields[4] as double,
      priceChangePercentage24h: fields[5] as double,
      marketCap: fields[6] as double,
      totalVolume: fields[7] as double,
      sparklineIn7d: (fields[8] as List).cast<double>(),
      image: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CoinModelHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.platforms)
      ..writeByte(4)
      ..write(obj.currentPrice)
      ..writeByte(5)
      ..write(obj.priceChangePercentage24h)
      ..writeByte(6)
      ..write(obj.marketCap)
      ..writeByte(7)
      ..write(obj.totalVolume)
      ..writeByte(8)
      ..write(obj.sparklineIn7d)
      ..writeByte(9)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
