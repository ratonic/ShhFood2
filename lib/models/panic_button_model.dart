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

  factory PanicButtonModel.fromJson(Map<String, dynamic> json) => PanicButtonModel(
        id: json['\$id'],
        title: json['title'],
        color: json['color'],
        contactIds: List<String>.from(json['contactIds'] ?? []),
        alertToPolice: json['alertToPolice'] ?? false,
        alertToAmbulance: json['alertToAmbulance'] ?? false,
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'color': color,
        'contactIds': contactIds,
        'alertToPolice': alertToPolice,
        'alertToAmbulance': alertToAmbulance,
        'userId': userId,
      };
}
