// Import the existing models
import 'add_car_brand_model.dart';
import 'add_car_category.dart';

class VehicleListModel {
  bool? status;
  String? message;
  List<VehicleData>? data;

  VehicleListModel({this.status, this.message, this.data});

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VehicleData>[];
      json['data'].forEach((v) {
        data!.add(VehicleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleData {
  String? id;
  String? refId;
  String? brandId;
  String? modelId;
  String? categoryId;
  String? licencePlateNumber;
  String? licenceExpireDate;
  String? vinNumber;
  String? transmission;
  String? fuelType;
  String? ownership;
  String? parcelWeightCapacity;
  bool? isActive;
  String? vehicleRequestStatus;
  String? denyNote;
  String? createdAt;
  String? updatedAt;
  String? brandName;
  String? modelName;
  String? categoryName;
  String? color;

  VehicleData({
    this.id,
    this.refId,
    this.brandId,
    this.modelId,
    this.categoryId,
    this.licencePlateNumber,
    this.licenceExpireDate,
    this.vinNumber,
    this.transmission,
    this.fuelType,
    this.ownership,
    this.parcelWeightCapacity,
    this.isActive,
    this.vehicleRequestStatus,
    this.denyNote,
    this.createdAt,
    this.updatedAt,
    this.brandName,
    this.modelName,
    this.categoryName,
    this.color,
  });

  VehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id']?.toString();
    brandId = json['brand_id'];
    modelId = json['model_id'];
    categoryId = json['category_id'];
    licencePlateNumber = json['licence_plate_number'];
    licenceExpireDate = json['licence_expire_date'];
    vinNumber = json['vin_number'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    ownership = json['ownership'];
    parcelWeightCapacity = json['parcel_weight_capacity']?.toString();
    isActive = json['is_active'];
    vehicleRequestStatus = json['vehicle_request_status'];
    denyNote = json['deny_note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brandName = json['brand_name'];
    modelName = json['model_name'];
    categoryName = json['category_name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    data['brand_id'] = brandId;
    data['model_id'] = modelId;
    data['category_id'] = categoryId;
    data['licence_plate_number'] = licencePlateNumber;
    data['licence_expire_date'] = licenceExpireDate;
    data['vin_number'] = vinNumber;
    data['transmission'] = transmission;
    data['fuel_type'] = fuelType;
    data['ownership'] = ownership;
    data['parcel_weight_capacity'] = parcelWeightCapacity;
    data['is_active'] = isActive;
    data['vehicle_request_status'] = vehicleRequestStatus;
    data['deny_note'] = denyNote;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['brand_name'] = brandName;
    data['model_name'] = modelName;
    data['category_name'] = categoryName;
    data['color'] = color;
    return data;
  }
}
