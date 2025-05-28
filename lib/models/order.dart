class OrderItem {
  final String name;
  final double price;
  final int quantity;

  OrderItem({
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'quantity': quantity,
  };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    name: json['name'] ?? '',
    price: (json['price'] ?? 0.0).toDouble(),
    quantity: json['quantity'] ?? 0,
  );
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'items': items.map((item) => item.toJson()).toList(),
    'total': total,
    'status': status,
    'created_at': createdAt.toIso8601String(),
  };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['\$id'] ?? '',
    items: (json['items'] as List? ?? [])
        .map((item) => OrderItem.fromJson(item))
        .toList(),
    total: (json['total'] ?? 0.0).toDouble(),
    status: json['status'] ?? 'pendiente',
    createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
  );

  static const String STATUS_PENDIENTE = 'pendiente';
  static const String STATUS_ACEPTADA = 'aceptada';
  static const String STATUS_EN_PREPARACION = 'en_preparacion';
  static const String STATUS_LISTA = 'lista';
  static const String STATUS_ENTREGADA = 'entregada';
}