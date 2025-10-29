/*

==============================================================================
| this file is used only to try the open street map it will be deleted later |
==============================================================================

*/

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PickAddressScreen extends StatefulWidget {
  const PickAddressScreen({super.key});

  @override
  State<PickAddressScreen> createState() => _PickAddressScreenState();
}

class _PickAddressScreenState extends State<PickAddressScreen> {
  final MapController _mapController = MapController();
  LatLng _pickedLocation = const LatLng(30.033333, 31.233334); // Cairo
  String? _address;

  Future<void> _onTap(_, LatLng position) async {
    setState(() => _pickedLocation = position);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address =
              "${place.street}, ${place.locality}, ${place.administrativeArea}";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveAddress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'address': _address ?? 'No address found',
      'location': {
        'lat': _pickedLocation.latitude,
        'lng': _pickedLocation.longitude,
      },
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Address saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick Your Address')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _pickedLocation,
              onTap: _onTap, // 👈 correct signature
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all, // ✅ allows zoom & pan
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // ✅ no {s}
                userAgentPackageName:
                    'com.yourappname.restaurantapp', //(Use your own app’s bundle ID.)
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _pickedLocation,
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Show address card
          if (_address != null)
            Positioned(
              bottom: 100,
              left: 10,
              right: 10,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(_address!, textAlign: TextAlign.center),
                ),
              ),
            ),

          // Save button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _saveAddress,
              child: const Text('Save Address'),
            ),
          ),
        ],
      ),
    );
  }
}
