// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:image_picker/image_picker.dart';
// // Logic & Data
// import '/logic/cubit/user_cubit.dart';
// import '/logic/cubit/user_state.dart';
// import '/data/models/user.dart';
// import '/data/services/user_services.dart';
// import '/presentation/screens/restaurant_details_screen.dart';
// import '/data/models/resturant.dart';
//
// class FillProfileScreen extends StatefulWidget {
//   const FillProfileScreen({super.key});
//
//   @override
//   State<FillProfileScreen> createState() => _FillProfileScreenState();
// }
//
// class _FillProfileScreenState extends State<FillProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _fullNameController = TextEditingController();
//   // final TextEditingController _nicknameController = TextEditingController();
//   // final TextEditingController _dateController = TextEditingController();
//   // final TextEditingController _emailController = TextEditingController();
//   String _phoneNumber = '';
//   String? _selectedGender;
//   final List<String> genderOptions = ['Male', 'Female'];
//   // DateTime? _selectedDate;
//
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserCubit, UserState>(
//       listener: (context, state) {
//         if (state is UserOperationSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => RestaurantDetailsScreen(
//                 restaurant: Resturant(
//                   name: "To The Bone",
//                   address: "NYC",
//                   rate: 4.8,
//                   offers_available: true,
//                   working_hours: "10-10",
//                   overview: "...",
//                   lat: 0,
//                   lng: 0,
//                 ),
//               ),
//             ),
//           );
//         } else if (state is UserError) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Fill Your Profile')),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // 1. Profile Pic
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 60,
//                         // Use Theme for placeholder background
//                         backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//                         backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
//                         child: _imageFile == null
//                             ? Icon(Icons.person, size: 60, color: Theme.of(context).disabledColor)
//                             : null,
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: GestureDetector(
//                           onTap: _pickImage,
//                           child: CircleAvatar(
//                             radius: 18,
//                             backgroundColor: Theme.of(context).primaryColor,
//                             child: const Icon(Icons.edit, size: 18, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//
//                   // 2. Full Name
//                   TextFormField(
//                     controller: _fullNameController,
//                     // Uses AppTheme's inputDecorationTheme automatically!
//                     decoration: const InputDecoration(hintText: 'Full Name'),
//                     validator: (val) {
//                       if (val == null || val.isEmpty) return 'Full Name is required';
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   // 3. Nickname
//                   // TextFormField(
//                   //   controller: _nicknameController,
//                   //   decoration: const InputDecoration(hintText: 'Nickname'),
//                   // ),
//                   // const SizedBox(height: 20),
//
//                   // 4. Date of Birth
//                   TextFormField(
//                     controller: _dateController,
//                     readOnly: true,
//                     decoration: const InputDecoration(
//                       hintText: 'Date of Birth',
//                       suffixIcon: Icon(Icons.calendar_today_outlined),
//                     ),
//                     validator: (val) => val == null || val.isEmpty ? 'Select date' : null,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: _selectedDate ?? DateTime(2000),
//                         firstDate: DateTime(1900),
//                         lastDate: DateTime.now(),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _selectedDate = pickedDate;
//                           _dateController.text = "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
//                         });
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   // 5. Email
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       hintText: 'Email',
//                       suffixIcon: Icon(Icons.email_outlined),
//                     ),
//                     validator: (val) {
//                       if (val == null || val.isEmpty) return 'Email is required';
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) return 'Invalid email';
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   // 6. Phone Number
//                   IntlPhoneField(
//                     // We have to manually apply decoration here because it's a custom widget
//                     decoration: const InputDecoration(hintText: 'Phone Number'),
//                     initialCountryCode: 'US',
//                     onChanged: (phone) {
//                       _phoneNumber = phone.completeNumber;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   // 7. Gender
//                   DropdownButtonFormField<String>(
//                     value: _selectedGender,
//                     hint: const Text('Gender'),
//                     items: genderOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                     onChanged: (val) => setState(() => _selectedGender = val),
//                     decoration: const InputDecoration(), // Empty decoration triggers Theme
//                     validator: (val) => val == null ? 'Select gender' : null,
//                   ),
//                   const SizedBox(height: 40),
//
//                   // 8. Continue Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: ElevatedButton(
//                       // Button Theme is handled by AppTheme, but we can override shape locally if needed
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       onPressed: state is UserLoading ? null : () {
//                         if (_formKey.currentState!.validate()) {
//                           final newUser = AppUser(
//                             id: UserServices.getCurrentUser(),
//                             name: _fullNameController.text,
//                             phone: int.tryParse(_phoneNumber) ?? 0,
//                             email: _emailController.text,
//                             gender: _selectedGender ?? 'Not Specified',
//                             longutude: 0.0,
//                             latitude: 0.0,
//                           );
//                           context.read<UserCubit>().updateUserProfile(newUser);
//                         }
//                       },
//                       child: state is UserLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text('Continue'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }