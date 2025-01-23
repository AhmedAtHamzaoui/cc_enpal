import 'package:cc_enpal/data/models/data_model.dart';
import 'package:dio/dio.dart';

abstract interface class EnergyRemoteDataSource {
  Future<List<DataModel>> getSolarEnergy(String date, String type);
}

class EnergyRemoteDataSourceImpl implements EnergyRemoteDataSource {
  final Dio dio;
  EnergyRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DataModel>> getSolarEnergy(String date, String type) async {
    try {
      final response = await dio
          .get('http://10.0.2.2:3000/monitoring?date=$date&type=$type');

      List<DataModel> data = (response.data as List)
          .map((item) => DataModel.fromJson(item))
          .toList();
      return data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
