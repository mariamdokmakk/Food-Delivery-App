import 'package:flutter/material.dart';
import '/data/services/resturant_services.dart';

class RestaurantInfoScreen extends StatelessWidget {
  const RestaurantInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The service requires an ID for working hours
    // We use the static ID from the service for this single-vendor app
    const String restaurantId = ResturantServices.restaurantId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. Overview Section (Stream) ---
              const Text(
                'Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              StreamBuilder<String>(
                stream: ResturantServices.getRestaurantOverview(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }
                  return Text(
                    snapshot.data ?? "No overview available",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // --- 2. Opening Hours Section (Stream) ---
              const Text(
                'Opening Hours',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              StreamBuilder<String>(
                stream: ResturantServices.getRestaurantWorkingHours(restaurantId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }

                  final hours = snapshot.data ?? "Not available";

                  return Row(
                    children: [
                      const Text('Everyday', style: TextStyle(fontSize: 16)),
                      const Spacer(),
                      Text(
                        hours,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // --- 3. Address Section (Future) ---
              const Text(
                'Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              FutureBuilder<Map<String, dynamic>?>(
                future: ResturantServices.getRestaurantLocation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data;
                  final address = data?['address'] ?? "Unknown location";
                  final lat = data?['lat']?.toString() ?? "0.0";
                  final lon = data?['lon']?.toString() ?? "0.0";

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                        title: Text(address, style: const TextStyle(fontSize: 16)),
                        subtitle: Text("Coordinates: $lat, $lon"),
                      ),
                      const SizedBox(height: 16),

                      // Map Placeholder
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(Icons.map, size: 50, color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}