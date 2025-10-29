class AddressModel {
  String? id;
  String name;
  String fullAddress;
  Map<String, double> coordinates;
  AddressModel({
    this.id,
    required this.name,
    required this.fullAddress,
    required this.coordinates,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'fullAddress': fullAddress,
      'coordinates': coordinates,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      name: map['name'] as String,
      fullAddress: map['fullAddress'] as String,
      coordinates: Map<String, double>.from(
        (map['coordinates'] as Map<String, double>),
      ),
    );
  }
}
