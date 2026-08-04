class CancelAmdStartTripeRequestModel {
  final int passengerId;
  final String stateTripe;

  CancelAmdStartTripeRequestModel(
      {required this.passengerId, required this.stateTripe});

  Map<String, dynamic> toJson() => {
        'carpool_passenger_id': passengerId,
        'decision': stateTripe,
      };
}
