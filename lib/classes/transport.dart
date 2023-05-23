class Transport {
  final String id;
  final int cargoCategory;
  final double maxWeight;

  Transport(this.id, this.cargoCategory, this.maxWeight);

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      json['_id'],
      json['cargo_category'],
      json['max_weight'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cargo_category': cargoCategory,
    'max_weight': maxWeight,
  };
}