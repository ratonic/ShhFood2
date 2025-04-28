class ContactModel {
  final String id;
  final String name;
  final String phone;
  final bool whatsapp;
  final String userId;

  ContactModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.whatsapp,
    required this.userId,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json['\$id'],
        name: json['name'],
        phone: json['phone'],
        whatsapp: json['whatsapp'] ?? false,
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'whatsapp': whatsapp,
        'userId': userId,
      };
}
