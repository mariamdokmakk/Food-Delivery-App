import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class ResturantServices {
  static String restaurantsCollection = "Restaurants";
  static const String restaurantId="UFrCk69XBDrXFMOCuMvB";
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //load all menu items in resturant
  //get restirant address

  //load best seller in resturant -----> already exist in home services


  /// دالة للحصول على موقع المستخدم الحالي
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تفعيل خدمة تحديد الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // التحقق من الأذونات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // رجّع موقع المستخدم
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  /// دالة لحساب المسافة بين المستخدم والمطعم بالكيلومتر
  static Future<double> getDistance(double restaurantLat, double restaurantLon) async {
    final userPosition = await getCurrentLocation();

    double distanceInMeters = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      restaurantLat,
      restaurantLon,
    );

    // نحولها من متر إلى كيلومتر
    double distanceInKm = distanceInMeters / 1000;
    return double.parse(distanceInKm.toStringAsFixed(2));
  }

  //get resturant overview
  static Stream<String> getRestaurantOverview() {
    final queryStream = _db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .snapshots();

    return queryStream.map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data()?['overview'] as String;
      } else {
        return "No overview found";
      }
    }
    );
  }

  //get resturant Working hours
static Stream<String> getRestaurantWorkingHours(String restaurantId) {
  final docStream = _db
      .collection(restaurantsCollection)
      .doc(restaurantId)
      .snapshots();

  return docStream.map((snapshot) {
    if (snapshot.exists) {
      return snapshot.data()?['workingHours'] as String? ?? "No working hours found";
    } else {
      return "No working hours found";
    }
  });
}


//get resturant location
static Future<Map<String, dynamic>?> getRestaurantLocation() async {
  final doc = await _db
      .collection(restaurantsCollection)
      .doc(restaurantId)
      .get();

  if (doc.exists) {
    final data = doc.data();
    if (data != null && data['location'] != null) {
      return {
        "lat": data['location']['lat'],
        "lon": data['location']['lon'],
        "address": data['address'],
      };
    }
  }
  return null;
}



}

