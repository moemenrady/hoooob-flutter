class AllVehiclesResponseModel {
  List<AllVehicleData>? allVehicle;

  AllVehiclesResponseModel({this.allVehicle});

  factory AllVehiclesResponseModel.fromJson(Map<String, dynamic> json) {
    return AllVehiclesResponseModel(
      allVehicle: json['data'] != null
          ? (json['data'] as List)
              .map((i) => AllVehicleData.fromJson(i))
              .toList()
          : null,
    );
  }
}

class AllVehicleData {
  String? vehicleId;
  String? vehicleModel;
  String? vehicleBrand;

  AllVehicleData({this.vehicleId, this.vehicleBrand, this.vehicleModel});

  factory AllVehicleData.fromJson(Map<String, dynamic> json) {
    return AllVehicleData(
      vehicleId: json['id'],
      vehicleBrand: json['brand_name'],
      vehicleModel: json['model_name'],
    );
  }
}
