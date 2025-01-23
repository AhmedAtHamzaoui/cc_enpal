import 'package:cc_enpal/data/models/data_model.dart';
import 'package:hive/hive.dart';

abstract interface class EnergyLocalDataSource {
  void uploadLocalData({required String type, required List<DataModel> data});
  List<DataModel> loadData({required String type});
}

class EnergyLocalDataSourceImpl implements EnergyLocalDataSource {
  final Box box;
  EnergyLocalDataSourceImpl(this.box);

  @override
  List<DataModel> loadData({required String type}) {
    // TODO: implement loadData
    throw UnimplementedError();
  }

  @override
  void uploadLocalData({required String type, required List<DataModel> data}) {
    // TODO: implement uploadLocalData
  }
}
