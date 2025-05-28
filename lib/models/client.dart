class Client {
  final String id;
  final String name;
  final String address;
  final String phone;

  Client({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'phone': phone,
  };

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json['id'],
    name: json['name'],
    address: json['address'],
    phone: json['phone'],
  );
}