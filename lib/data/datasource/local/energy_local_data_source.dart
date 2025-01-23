import 'package:cc_enpal/data/models/data_model.dart';
import 'package:hive/hive.dart';

abstract interface class EnergyLocalDataSource {
  void uploadLocalData(
      {required String type,
      required String date,
      required List<DataModel> data});
  List<DataModel> loadData({required String type, required String date});
  void clearAllData();
}

class EnergyLocalDataSourceImpl implements EnergyLocalDataSource {
  final Box box;
  EnergyLocalDataSourceImpl(this.box);

  @override
  void uploadLocalData(
      {required String type,
      required String date,
      required List<DataModel> data}) {
    final String key = _generateKey(type, date);
    final List<Map<String, dynamic>> serializedData =
        data.map((e) => e.toJson()).toList();

    box.put(key, serializedData);
  }

  @override
  List<DataModel> loadData({required String type, required String date}) {
    final String key = _generateKey(type, date);
    final List<dynamic>? rawData = box.get(key);
    if (rawData != null) {
      return rawData
          .map((e) => DataModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  @override
  void clearAllData() {
    box.clear(); // Clears all entries in Hive
  }

  String _generateKey(String type, String date) {
    return '$type-$date';
  }
}
