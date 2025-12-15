import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/presentation/screens/set_location.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/user.dart';
import '../../data/services/user_services.dart';
import '/presentation/widgets/show_snak_bar.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController userValue = TextEditingController();
  TextEditingController passvalue = TextEditingController();
  TextEditingController namevalue = TextEditingController();
  // TextEditingController _dateController = TextEditingController();
  String _phoneNumber = '';
  // String? _selectedGender;
  // final List<String> genderOptions = ['Male', 'Female'];

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  DateTime? _selectedDate;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset("assets/images/logo.png", height: 80),
                ),
                Center(
                  child:  Text(
                    'Create New Account',
                    style: TextStyle(
                      fontSize: 27,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 1. Profile Picture
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null
                            ? const Icon(Icons.person, size: 50, color: Colors.grey)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor:  Theme.of(context).colorScheme.primary,
                            child: const Icon(Icons.edit, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),


                // 2. Full Name
                TextFormField(
                  cursorColor:  Theme.of(context).colorScheme.primary,
                  controller: namevalue,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'name is required';
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.grey),
                    hintText: 'Name',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color:  Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Email
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.primary,
                  controller: userValue,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    if (!value.contains('@')) return 'Enter valid email';
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color:  Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                IntlPhoneField(
                  cursorColor:  Theme.of(context).colorScheme.primary,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color:  Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  initialCountryCode: 'EG',
                  onChanged: (phone) {
                    _phoneNumber = phone.completeNumber;
                  },
                  validator: (value) {
                    if (value == null || value.number.isEmpty) return 'Phone is required';
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                // 5. Password
                TextFormField(
                  cursorColor:  Theme.of(context).colorScheme.primary,
                  controller: passvalue,
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        !obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:  BorderSide(color:  Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 8. Sign Up Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // 1️⃣ Create Firebase Auth user
                        UserCredential credential =
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: userValue.text.trim(),
                          password: passvalue.text.trim(),
                        );

                        User user = credential.user!;

                        // 2️⃣ Upload image to Cloudinary (if exists)
                        String? imageUrl;
                        if (_imageFile != null) {
                          imageUrl = await UserServices.uploadProfileImage(_imageFile!);
                        }

                        //  Create AppUser model
                        AppUser appUser = AppUser(
                          id: user.uid,
                          name: namevalue.text.trim(),
                          email: user.email!,
                          phone: _phoneNumber,
                          profileImage: imageUrl ?? "",
                          // longitude: 0,
                          // latitude: 0,
                        );

                        // 4️⃣ Save user to Firestore
                        await UserServices.createUser(appUser);

                        // 5️⃣ Navigate
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SetLocationScreen()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakBar(context, 'Password is too weak');
                        } else if (e.code == 'email-already-in-use') {
                          showSnakBar(context, 'Email already exists');
                        }
                      } catch (e) {
                        showSnakBar(context, 'Error: $e');
                      }
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

