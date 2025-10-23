class AppUser {
  String id;
  String name;
  int phone;
  String email;
  String gender;
  double longutude;
  double latitude;
  AppUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.longutude,
    required this.latitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'gender': gender,
      'longutude': longutude,
      'latitude': latitude,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as int,
      email: map['email'] as String,
      gender: map['gender'] as String,
      longutude: map['longutude'] as double,
      latitude: map['latitude'] as double,
    );
  }
}
