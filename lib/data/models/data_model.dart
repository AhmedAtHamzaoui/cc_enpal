import 'package:cc_enpal/domain/entities/data.dart';

class DataModel extends Data {
  DataModel({
    required super.timestamp,
    required super.eValue,
  });

   Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'value': eValue,
    };
  }

factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      timestamp: json['timestamp'],
      eValue: json['value'],
    );
  }
  
  DataModel copyWith({
    String? timestamp,
    int? eValue,
  }) {
    return DataModel(
      timestamp: timestamp ?? this.timestamp,
      eValue: eValue ?? this.eValue,
    );
  }
}