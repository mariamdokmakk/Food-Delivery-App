// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/data/models/address_model.dart';
// import '/logic/cubit/user_cubit.dart';
//
// class AddAddressScreen extends StatefulWidget {
//   const AddAddressScreen({super.key});
//
//   @override
//   State<AddAddressScreen> createState() => _AddAddressScreenState();
// }
//
// class _AddAddressScreenState extends State<AddAddressScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add New Address')),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // 1. Address Name Field (Home, Work, etc.)
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Address Name',
//                   hintText: 'e.g., Home, Office',
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 validator: (val) => val!.isEmpty ? 'Enter a name' : null,
//               ),
//               const SizedBox(height: 16),
//
//               // 2. Full Address Field
//               TextFormField(
//                 controller: _addressController,
//                 decoration: InputDecoration(
//                   labelText: 'Full Address',
//                   hintText: 'e.g., 123 Main St, New York',
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   suffixIcon: const Icon(Icons.location_on),
//                 ),
//                 validator: (val) => val!.isEmpty ? 'Enter address' : null,
//               ),
//               const SizedBox(height: 32),
//
//               // 3. Save Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // Create the Address Model
//                       final newAddress = AddressModel(
//                         name: _nameController.text,
//                         fullAddress: _addressController.text,
//                         coordinates: {'lat': 0.0, 'lng': 0.0}, // Dummy coords for now
//                       );
//
//                       // Call Cubit to save
//                       context.read<UserCubit>().addNewAddress(newAddress);
//
//                       // Go back
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: const Text('Add Address'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }