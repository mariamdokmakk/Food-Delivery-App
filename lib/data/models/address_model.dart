class AddressModel {
  String id;
  final String label; // Home, Work, etc.
  final String description; // Full formatted address
  final double latitude;
  final double longitude;

  AddressModel({
    required this.id,
    required this.label,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      "label": label,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory AddressModel.fromMap(String id, Map<String, dynamic> map) {
    return AddressModel(
      id: id,
      label: map["label"],
      description: map["description"],
      latitude: map["latitude"],
      longitude: map["longitude"],
    );

  }
}
