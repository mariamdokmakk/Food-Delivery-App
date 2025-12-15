import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/address_model.dart';
import 'main_home_screen.dart';

class SetLocationScreen extends StatefulWidget {
  @override
  _SetLocationScreenState createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  LatLng? selectedLocation;
  final MapController mapController = MapController();
  late TextEditingController labelController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
    });

    mapController.move(selectedLocation!, 15);
  }

  Future<void> _setAutoDescription(double lat, double lng) async {
    try {
      final url = Uri.parse(
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng");
      final response = await http.get(url, headers: {'User-Agent': 'MyApp/1.0'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // full address
        String address = data['display_name'] ?? "";

        setState(() {
          descriptionController.text = address;
        });
      } else {
        print("Error fetching address: ${response.statusCode}");
      }
    } catch (e) {
      print("Error getting place info: $e");
    }
  }

  // Future<void> _setAutoDescription(double lat, double lng) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  //     Placemark p = placemarks.first;
  //
  //     String autoDescription =
  //         "${p.administrativeArea ?? ""}, ${p.locality ?? ""}, ${p.street ?? ""}";
  //
  //     setState(() {
  //       descriptionController.text = autoDescription; // fill textbox
  //     });
  //   } catch (e) {
  //     print("Error getting place info: $e");
  //   }
  // }

  Future<dynamic> _saveLocation(String label, String description) async {
    if (selectedLocation == null) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Create the model object
      final address = AddressModel(
        id: "", // Firestore will generate it
        label: label,
        description: description,
        latitude: selectedLocation!.latitude,
        longitude: selectedLocation!.longitude,
      );

      // Save to Firestore sub-collection
      final docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .add(address.toMap());

      // After adding, update the model ID if you need it
      await docRef.update({"id": docRef.id});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Your Location")),
      body: selectedLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: selectedLocation!,
              initialZoom: 15,
              onTap: (tapPosition, point) async {
                setState(() {
                  selectedLocation = point; // Update marker on tap
                });
                await _setAutoDescription(point.latitude,point.longitude);
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.myapp',
              ),

              // Marker Layer
              MarkerLayer(
                markers: [
                  Marker(
                    point: selectedLocation!,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 50,
                    ),
                  )
                ],
              )
            ],
          ),

          // Save Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Save Address"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: labelController,
                              decoration: InputDecoration(
                                labelText: "Label (Home, Work...)",
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: "Description",
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: Text("Save"),
                            onPressed: () async {
                              await _saveLocation(
                                labelController.text.trim(),
                                descriptionController.text.trim(),
                              );

                              Navigator.pop(context); // close dialog
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MainHomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }

                ,style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.green,
              ),
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
