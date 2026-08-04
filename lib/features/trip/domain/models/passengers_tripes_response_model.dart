class PassengerAllTripeResponseModel {
  String responseCode;
  String message;
  int? totalSize;
  int? limit;
  int? offset;
  List<TripePassengerData> data;
  List<dynamic> errors;

  PassengerAllTripeResponseModel({
    required this.responseCode,
    required this.message,
    this.totalSize,
    this.limit,
    this.offset,
    required this.data,
    required this.errors,
  });

  factory PassengerAllTripeResponseModel.fromJson(Map<String, dynamic> json) {
    return PassengerAllTripeResponseModel(
      responseCode: json['response_code'],
      message: json['message'],
      totalSize: json['total_size'],
      limit: json['limit'],
      offset: json['offset'],
      data: (json['data'] as List)
          .map((item) => TripePassengerData.fromJson(item))
          .toList(),
      errors: json['errors'] ?? [],
    );
  }
}

class TripePassengerData {
  String routeId;
  String driverName;
  String? driverImage;
  String startDay;
  String startHour;
  String startAddress;
  String endAddress;
  String status;

  TripePassengerData({
    required this.routeId,
    required this.driverName,
    this.driverImage,
    required this.startDay,
    required this.startHour,
    required this.startAddress,
    required this.endAddress,
    required this.status,
  });

  factory TripePassengerData.fromJson(Map<String, dynamic> json) {
    return TripePassengerData(
      routeId: json['route_id'],
      driverName: json['driver_name'],
      driverImage: json['driver_image'],
      startDay: json['start_day'],
      startHour: json['start_hour'],
      startAddress: json['start_address'],
      endAddress: json['end_address'],
      status: json['status'],
    );
  }
}
