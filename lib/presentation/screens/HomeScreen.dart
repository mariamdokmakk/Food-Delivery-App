import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('restaurants')
            .doc('big_garden_salad')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(data['image_url'], height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),

                // Title and rating
                Text(data['name'],
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text("${data['rating']} (${data['reviews']} reviews)",
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.greenAccent, size: 18),
                    const SizedBox(width: 4),
                    Text("${data['distance_km']} km • Delivery \$${data['delivery_fee']}",
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 6),

                if (data['offers_available'] == true)
                  const Text("Offers are available",
                      style: TextStyle(color: Colors.greenAccent)),

                const SizedBox(height: 20),

                _buildSection("For You", data['for_you']),
                const SizedBox(height: 20),
                _buildSection("Menu", data['menu']),
                const SizedBox(height: 20),
                _buildSection("Drink", data['drinks']),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        if (title == "For You")
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return _menuCard(item, isHorizontal: true);
              },
            ),
          )
        else
          Column(
            children: items.map((item) => _menuCard(item)).toList(),
          ),
      ],
    );
  }

  Widget _menuCard(Map<String, dynamic> item, {bool isHorizontal = false}) {
    return Container(
      margin: EdgeInsets.only(right: isHorizontal ? 12 : 0, bottom: isHorizontal ? 0 : 12),
      width: isHorizontal ? 140 : double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['image_url'],
              height: isHorizontal ? 100 : 60,
              width: isHorizontal ? 140 : 60,
              fit: BoxFit.cover,
            ),
          ),
          if (!isHorizontal)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  "${item['name']} - \$${item['price']}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\$${item['price']}",
                style: const TextStyle(color: Colors.white),
              ),
            )
        ],
      ),
    );
  }
}
