class Transport {
  final String id;
  final int cargoCategory;
  final double maxWeight;

  Transport(this.id, this.cargoCategory, this.maxWeight);

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      json['id'],
      json['cargo_category'],
      json['max_weight'],
    );
  }
}