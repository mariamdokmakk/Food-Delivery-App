// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '/presentation/widgets/show_snak_bar.dart';
// import '/presentation/screens/login_page.dart';
// import '/presentation/widgets/constants.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
//
// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   bool obscureText = true;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController userValue = TextEditingController();
//   TextEditingController passvalue = TextEditingController();
//   TextEditingController namevalue = TextEditingController();
//   TextEditingController phonevalue = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(30),
//                   child: Image.asset("assets/images/logo.jpg", height: 80),
//                 ),
//                 Center(
//                   child: const Text(
//                     'Create New Account',
//                     style: TextStyle(
//                       fontSize: 27,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//
//                 IntlPhoneField(
//                   cursorColor: primaryGreen,
//                   controller: phonevalue,
//                   validator: (value) {
//                     if (value == null || value.number.isEmpty) {
//                       return 'phone is required';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     hintText: ' 000 000 000',
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: primaryGreen),
//                     ),
//                   ),
//                   initialCountryCode: 'EG', // Sets the initial country to Egypt
//                   onChanged: (phone) {
//                     print(
//                       phone.completeNumber,
//                     ); // You can see the full number in the console
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 TextFormField(
//                   cursorColor: primaryGreen,
//                   controller: namevalue,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'full name is required';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                     hintText: 'Full Name',
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: primaryGreen),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 TextFormField(
//                   cursorColor: primaryGreen,
//                   controller: userValue,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'email is required';
//                     } else if (!value.contains('@')) {
//                       return 'enter valid email';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.email, color: Colors.grey),
//                     hintText: 'Email',
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: primaryGreen),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   cursorColor: primaryGreen,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'password is required';
//                     }
//                     return null;
//                   },
//                   controller: passvalue,
//                   obscureText: obscureText,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           obscureText = !obscureText;
//                         });
//                       },
//                       icon: Icon(
//                         !obscureText ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     hintText: 'Password',
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: const BorderSide(color: primaryGreen),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//
//                       try {
//                         await registerUser();
//                         User? user = FirebaseAuth.instance.currentUser;
//                         await saveUserToFirestore(
//                           user!,
//                           namevalue.text,
//                         ); // Save user info to Firestore
//                         Navigator.of(context)
//                             .push(
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return LoginPage();
//                                 },
//                               ),
//                             )
//                             .then((value) {
//                               userValue.clear();
//                               passvalue.clear();
//                               phonevalue.clear();
//                               namevalue.clear();
//                             });
//                       } on FirebaseAuthException catch (e) {
//                         if (e.code == 'weak-password') {
//                           showSnakBar(
//                             context,
//                             'The password provided is too weak.',
//                           );
//                         } else if (e.code == 'email-already-in-use') {
//                           showSnakBar(
//                             context,
//                             'The account already exists for that email.',
//                           );
//                         }
//                       }
//                       catch (e) {
//                         showSnakBar(
//                           context,
//                           'there was an error ,please try agian,$e.',
//                         );
//                       }
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryGreen,
//                     minimumSize: const Size(150, 50),
//                   ),
//                   child: const Text(
//                     'Sign up',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Already have an account?",
//                         style: TextStyle(color: Colors.grey, fontSize: 18),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return LoginPage();
//                               },
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Sign in",
//                           style: TextStyle(color: primaryGreen),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> registerUser() async {
//     final credential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//           email: userValue.text,
//           password: passvalue.text,
//         );
//   }
// }
//
// Future<void> saveUserToFirestore(User user, String username) async {
//   final usersRef = FirebaseFirestore.instance.collection("users");
//
//   await usersRef.doc(user.uid).set({
//     "uid": user.uid,
//     "email": user.email,
//     "name": username,
//     "phone": user.phoneNumber,
//   }, SetOptions(merge: true));
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/presentation/screens/set_location.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import '/presentation/widgets/show_snak_bar.dart';
import '/presentation/screens/login_page.dart';
import '/presentation/widgets/constants.dart';

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
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset("assets/images/logo.jpg", height: 80),
                ),
                Center(
                  child: const Text(
                    'Create New Account',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.black,
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
                            backgroundColor: primaryGreen,
                            child: const Icon(Icons.edit, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Phone Number


                // 3. Full Name
                TextFormField(
                  cursorColor: primaryGreen,
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
                      borderSide: const BorderSide(color: primaryGreen),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Email
                TextFormField(
                  cursorColor: primaryGreen,
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
                      borderSide: const BorderSide(color: primaryGreen),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                IntlPhoneField(
                  cursorColor: primaryGreen,
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
                      borderSide: const BorderSide(color: primaryGreen),
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
                  cursorColor: primaryGreen,
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
                      borderSide: const BorderSide(color: primaryGreen),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 8. Sign Up Button
                ElevatedButton(
                  onPressed: ()
                  async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserCredential credential =
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: userValue.text,
                          password: passvalue.text,
                        );

                        User? user = credential.user;

                        if (user != null) {
                          await saveUserToFirestore(
                            user,
                            namevalue.text,
                            _phoneNumber,
                            _imageFile,
                          );

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SetLocationScreen()),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakBar(context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnakBar(context, 'The account already exists for that email.');
                        }
                      } catch (e) {
                        showSnakBar(context, 'There was an error, please try again. $e');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
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

// Save user to Firestore with new fields
Future<void> saveUserToFirestore(
    User user,
    String name,
    String phone,
    File? imageFile,
    ) async {
  final usersRef = FirebaseFirestore.instance.collection("users");

  String? imageUrl;

  if (imageFile != null) {
    final ref = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(user.uid)
        .child("profile.jpg");

    await ref.putFile(imageFile);
    imageUrl = await ref.getDownloadURL();
  }

  await usersRef.doc(user.uid).set({
    "uid": user.uid,
    "name": name,
    "email": user.email,
    "phone": phone,
    "profile_image": imageUrl ?? "",
  }, SetOptions(merge: true));
}

