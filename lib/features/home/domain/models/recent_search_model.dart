class RecentSearchModel {
  final String id;
  final String fromLocation;
  final String toLocation;
  final String date;
  final int passengers;
  final double? startLat;
  final double? startLng;
  final double? endLat;
  final double? endLng;
  final DateTime createdAt;

  RecentSearchModel({
    required this.id,
    required this.fromLocation,
    required this.toLocation,
    required this.date,
    required this.passengers,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'date': date,
      'passengers': passengers,
      'startLat': startLat,
      'startLng': startLng,
      'endLat': endLat,
      'endLng': endLng,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) {
    return RecentSearchModel(
      id: json['id'] ?? '',
      fromLocation: json['fromLocation'] ?? '',
      toLocation: json['toLocation'] ?? '',
      date: json['date'] ?? '',
      passengers: json['passengers'] ?? 1,
      startLat: json['startLat']?.toDouble(),
      startLng: json['startLng']?.toDouble(),
      endLat: json['endLat']?.toDouble(),
      endLng: json['endLng']?.toDouble(),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  RecentSearchModel copyWith({
    String? id,
    String? fromLocation,
    String? toLocation,
    String? date,
    int? passengers,
    double? startLat,
    double? startLng,
    double? endLat,
    double? endLng,
    DateTime? createdAt,
  }) {
    return RecentSearchModel(
      id: id ?? this.id,
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
      date: date ?? this.date,
      passengers: passengers ?? this.passengers,
      startLat: startLat ?? this.startLat,
      startLng: startLng ?? this.startLng,
      endLat: endLat ?? this.endLat,
      endLng: endLng ?? this.endLng,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
