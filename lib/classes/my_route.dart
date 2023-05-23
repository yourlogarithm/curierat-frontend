import 'package:curierat_frontend/classes/package.dart';
import 'package:curierat_frontend/classes/transport.dart';

class MyRoute {
  final List<String> cities;
  final Transport transport;
  final List<DateTime> schedule;
  final int currentPosition;
  final List<Package> packages;
  final double currentWeight;
  final String id;

  MyRoute(this.cities, this.transport, this.schedule, this.currentPosition, this.packages, this.currentWeight, this.id);

  factory MyRoute.fromJson(Map<String, dynamic> json) {
    return MyRoute(
      List<String>.from(json['cities']),
      Transport.fromJson(json['transport']),
      List<DateTime>.from(json['schedule'].map((item) => DateTime.parse(item)).toList()),
      json['current_position'],
      List.from(json['packages'].map((item) => Package.fromJson(item)).toList()),
      json['current_weight'],
      json['_id'],
    );
  }
}