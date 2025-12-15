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
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  File? _imageFile;
  String? _existingImageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    final state = context.read<UserCubit>().state;
    if (state is UserLoaded) {
      _nameController.text = state.user.name;
      _emailController.text = state.user.email;
      _phoneController.text = state.user.phone;
      _existingImageUrl = state.user.profileImage; // 🔹 store existing image
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
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Edit Profile',style: TextStyle(color: Theme.of(context).iconTheme.color))),

      // --- UPDATE BUTTON ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  String? finalImageUrl = _existingImageUrl;

                  // 🔹 Upload new image if user selected one
                  if (_imageFile != null) {
                    finalImageUrl =
                    await UserServices.uploadProfileImage(_imageFile!);
                  }

                  final updatedUser = AppUser(
                    id: UserServices.getCurrentUser(),
                    name: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    phone: _phoneController.text.trim(),
                    profileImage: finalImageUrl ?? "",
                  );

                  await context
                      .read<UserCubit>()
                      .updateUserProfile(updatedUser);

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
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
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : (_existingImageUrl != null && _existingImageUrl!.isNotEmpty)
                        ? NetworkImage(_existingImageUrl!)
                        : const AssetImage('assets/images/avatar.png') as ImageProvider,
                      backgroundColor: Colors.grey.shade200,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(Icons.edit, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

             SizedBox(height: 24),

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
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
   }
  Future<void> _pickImage() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }
}
