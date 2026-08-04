class AddCarBodyModel {
  String? brandId;
  String? modelId;
  String? categoryId;
  String? licencePlateNumber;
  String? licenceExpireDate;
  String? vinNumber;
  String? transmission;
  String? fuelType;
  String? driverId;
  String? ownership;
  String? parcelCapacityWeight;

  AddCarBodyModel(
      {this.brandId,
      this.modelId,
      this.categoryId,
      this.licencePlateNumber,
      this.licenceExpireDate,
      this.vinNumber,
      this.transmission,
      this.fuelType,
      this.driverId,
      this.ownership,
      this.parcelCapacityWeight});

  AddCarBodyModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    modelId = json['model_id'];
    categoryId = json['category_id'];
    licencePlateNumber = json['licence_plate_number'];
    licenceExpireDate = json['licence_expire_date'];
    vinNumber = json['vin_number'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    driverId = json['driver_id'];
    ownership = json['ownership'];
    parcelCapacityWeight = json['parcel_weight_capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brandId!;
    data['model_id'] = modelId!;
    data['category_id'] = categoryId!;
    data['licence_plate_number'] = licencePlateNumber!;
    data['licence_expire_date'] = licenceExpireDate!;
    data['vin_number'] = vinNumber!;
    data['transmission'] = transmission!;
    data['fuel_type'] = fuelType!;
    data['driver_id'] = driverId!;
    data['ownership'] = ownership!;
    // Convert parcel_weight_capacity to number if it's not empty
    if (parcelCapacityWeight != null && parcelCapacityWeight!.isNotEmpty) {
      data['parcel_weight_capacity'] = int.tryParse(parcelCapacityWeight!) ?? 0;
    } else {
      data['parcel_weight_capacity'] = 0;
    }
    return data;
  }
}
