class Restaurant {
  final String restaurantId;
  final String name;
  final String address;
  final String phone;
  final String description;
  final String serviceHours;
  final String imageUrl;

  Restaurant({
    required this.restaurantId,
    required this.name,
    required this.address,
    required this.phone,
    required this.description,
    required this.serviceHours,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'restaurantId': restaurantId,
    'name': name,
    'address': address,
    'phone': phone,
    'description': description,
    'serviceHours': serviceHours,
    'imageUrl': imageUrl,
  };

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    restaurantId: json['restaurantId'],
    name: json['name'],
    address: json['address'],
    phone: json['phone'],
    description: json['description'],
    serviceHours: json['serviceHours'],
    imageUrl: json['imageUrl'],
  );
}