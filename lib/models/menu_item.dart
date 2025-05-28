class MenuItem {
  final String id;
  final String name;
  final double price;
  final String description;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'description': description,
  };

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    id: json['\$id'] ?? '',
    name: json['name'] ?? '',
    price: (json['price'] ?? 0.0).toDouble(),
    description: json['description'] ?? '',
  );
}