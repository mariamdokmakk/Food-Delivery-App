import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/data/services/resturant_services.dart';

class RestaurantMapScreen extends StatefulWidget {
  const RestaurantMapScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantMapScreen> createState() => _RestaurantMapScreenState();
}

class _RestaurantMapScreenState extends State<RestaurantMapScreen> {
  LatLng? restaurantLatLng;
  LatLng? userLatLng;
  double? distanceKm;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMapData();
  }

  Future<void> loadMapData() async {
    try {
      // 1️⃣ نجيب بيانات المطعم من Firestore
      final data = await ResturantServices.getRestaurantLocation();

      // 2️⃣ نجيب موقع المستخدم الحالي
      final position = await ResturantServices.getCurrentLocation();

      // 3️⃣ نحسب المسافة بالكيلومتر بين المستخدم والمطعم
      double distance = await ResturantServices.getDistance(
        data?['lat'],
        data?['lon'],
      );

      setState(() {
        restaurantLatLng = LatLng(data?['lat'], data?['lon']);
        userLatLng = LatLng(position.latitude, position.longitude);
        distanceKm = distance;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading map data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant Location")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: restaurantLatLng!,
                      initialZoom: 14,
                    ),
                    children: [
                      // 🗺️ خريطة مجانية من OpenStreetMap
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.foodapp',
                      ),

                      // 📍Markers للمطعم والمستخدم
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: restaurantLatLng!,
                            width: 80,
                            height: 80,
                            child: const Icon(
                              Icons.restaurant,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                          if (userLatLng != null)
                            Marker(
                              point: userLatLng!,
                              width: 80,
                              height: 80,
                              child: const Icon(
                                Icons.person_pin_circle,
                                color: Colors.blue,
                                size: 40,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 🧭 المسافة بين المستخدم والمطعم
                if (distanceKm != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.orange.shade50,
                    child: Text(
                      "يبعد عنك تقريبًا: ${distanceKm!.toStringAsFixed(2)} كم",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
