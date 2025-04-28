import 'package:hive/hive.dart';

part 'alert_log_model.g.dart';

@HiveType(typeId: 3)
class AlertLogModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String buttonId;
  @HiveField(2)
  final DateTime timestamp;
  @HiveField(3)
  final double latitude;
  @HiveField(4)
  final double longitude;
  @HiveField(5)
  final String userId;

  AlertLogModel({
    required this.id,
    required this.buttonId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.userId,
  });

  factory AlertLogModel.fromJson(Map<String, dynamic> json) => AlertLogModel(
        id: json['\$id'],
        buttonId: json['buttonId'],
        timestamp: DateTime.parse(json['timestamp']),
        latitude: json['latitude'],
        longitude: json['longitude'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'buttonId': buttonId,
        'timestamp': timestamp.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'userId': userId,
      };
}
