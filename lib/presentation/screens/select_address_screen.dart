// import 'package:flutter/material.dart';
// import '/presentation/widgets/address_tile.dart';
//
// class SelectAddressScreen extends StatefulWidget {
//   const SelectAddressScreen({super.key});
//
//   @override
//   State<SelectAddressScreen> createState() => _SelectAddressScreenState();
// }
//
// class _SelectAddressScreenState extends State<SelectAddressScreen> {
//   int _selectedIndex = 0; // Tracks which address is selected
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Address'),
//       ),
//       // 2. "Add New Address" button
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             // TODO: Navigate to an "Add New Address" screen
//           },
//           child: const Text('Add New Address'),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           // This Column is NOT constant
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 1. List of addresses
//               // This ListView is NOT constant
//               ListView(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   AddressTile(
//                     title: 'Home',
//                     address: 'Times Square NYC, Manhattan',
//                     icon: Icons.home,
//                     isDefault: true,
//                     isSelected: _selectedIndex == 0,
//                     onTap: () {
//                       setState(() {
//                         _selectedIndex = 0;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   AddressTile(
//                     title: 'Office',
//                     address: '88 Commercial Plaza, NY',
//                     icon: Icons.work,
//                     isSelected: _selectedIndex == 1,
//                     onTap: () {
//                       setState(() {
//                         _selectedIndex = 1;
//                       });
//                     },
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/presentation/widgets/address_tile.dart';
import '/data/services/user_services.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  int _selectedIndex = 0;

  Future<List<Map<String, dynamic>>> _loadAddresses() async {
    final userId = UserServices.getCurrentUser();
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .get();

    return snap.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Add New Address'),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _loadAddresses(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final addresses = snapshot.data!;

            if (addresses.isEmpty) {
              return const Center(
                child: Text("No addresses found. Add one!"),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final address = addresses[index];
                return AddressTile(
                  title: address['label'] ?? 'Address',
                  address: address['description'] ?? "Unknown location",
                  icon: Icons.location_on,
                  isDefault: index == 0,
                  isSelected: _selectedIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      Navigator.pop(context, addresses[_selectedIndex]);
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
