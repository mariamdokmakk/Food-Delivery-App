import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// Note: If you have a custom text field widget, you can use it,
// but standard TextFormField is safer for Edit screens to avoid controller conflicts.
// import 'package:food_delivery/presentation/widgets/custom_text_field.dart';

// Logic & Data Imports
import '/logic/cubit/user_cubit.dart';
import '/logic/cubit/user_state.dart';
import '/data/models/user.dart';
import '/data/services/user_services.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // 1. Pre-fill data from Cubit when screen opens
    final state = context.read<UserCubit>().state;
    if (state is UserLoaded) {
      _nameController.text = state.user.name;
      _emailController.text = state.user.email;
      _phoneController.text = state.user.phone.toString();
      // _selectedGender = state.user.gender.isNotEmpty ? state.user.gender : 'Male';
      // Note: You might need to handle Date if your model has it
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),

      // --- UPDATE BUTTON ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              print("🟢 Update Button Pressed");

              // 1. Check Form Validation
              if (_formKey.currentState!.validate()) {
                print("🟢 Form is Valid. Preparing data...");

                try {
                  // 2. Get User ID safely
                  final currentUserId = UserServices.getCurrentUser();
                  print("🟢 User ID found: $currentUserId");

                  // 3. Create the User Object
                  final updatedUser = AppUser(
                    id: currentUserId,
                    name: _nameController.text,
                    email: _emailController.text,

                    profileImage: " ",
                    phone: _phoneController.text,
                    // gender: _selectedGender,
                    // Keep existing location data if possible (dummy for now)
                    longitude: 0.0,
                    latitude: 0.0,
                  );

                  print("🟢 Sending data to Cubit...");

                  // 4. Send to Firebase via Cubit
                  context.read<UserCubit>().updateUserProfile(updatedUser);

                  print("🟢 Closing screen...");

                  // 5. Go Back
                  Navigator.pop(context);

                } catch (e) {
                  print("🔴 ERROR during update: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              } else {
                print("🔴 Form is Invalid (A field is empty or wrong)");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill in all required fields")),
                );
              }
            },
            child: const Text('Update'),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey, // This connects the form key to the fields
          child: Column(
            children: [
              // Profile Pic
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: const AssetImage('assets/images/avatar.png'),
                    backgroundColor: Colors.grey[200],
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.edit, size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Full Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your name',
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  filled: true,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              // Phone
              // We use standard TextFormField for editing to prevent controller conflicts
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              // Gender
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(
              //       labelText: 'Gender',
              //       filled: true,
              //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)
              //   ),
              //   value: _selectedGender,
              //   // items: genderOptions.map((String gender) {
              //   //   return DropdownMenuItem<String>(
              //   //     value: gender,
              //   //     child: Text(gender),
              //   //   );
              //   // }).toList(),
              //   onChanged: (val) {
              //     if(val != null) {
              //       setState(() => _selectedGender = val);
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}