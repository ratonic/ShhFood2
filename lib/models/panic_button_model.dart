// lib/models/panic_button_model.dart

class PanicButtonModel {
  final String id;
  final String title;
  final int color;
  final List<String> contactIds;
  final bool alertToPolice;
  final bool alertToAmbulance;
  final String userId;

  PanicButtonModel({
    required this.id,
    required this.title,
    required this.color,
    required this.contactIds,
    required this.alertToPolice,
    required this.alertToAmbulance,
    required this.userId,
  });

  /// Este método te permite clonar la instancia cambiando sólo los campos que quieras.
  PanicButtonModel copyWith({
    String? id,
    String? title,
    int? color,
    List<String>? contactIds,
    bool? alertToPolice,
    bool? alertToAmbulance,
    String? userId,
  }) {
    return PanicButtonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      contactIds: contactIds ?? this.contactIds,
      alertToPolice: alertToPolice ?? this.alertToPolice,
      alertToAmbulance: alertToAmbulance ?? this.alertToAmbulance,
      userId: userId ?? this.userId,
    );
  }

  factory PanicButtonModel.fromJson(Map<String, dynamic> json) {
    return PanicButtonModel(
      id: json['\$id'] as String,
      title: json['title'] as String,
      color: json['color'] as int,
      contactIds: List<String>.from(json['contactIds'] ?? <String>[]),
      alertToPolice: json['alertToPolice'] as bool? ?? false,
      alertToAmbulance: json['alertToAmbulance'] as bool? ?? false,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'color': color,
        'contactIds': contactIds,
        'alertToPolice': alertToPolice,
        'alertToAmbulance': alertToAmbulance,
        'userId': userId,
      };
}
