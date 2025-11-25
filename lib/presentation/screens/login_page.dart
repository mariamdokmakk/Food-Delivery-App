import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/presentation/screens/deleted/fill_profile_screen.dart';
import '/presentation/widgets/show_snak_bar.dart';
import '/presentation/screens/main_home_screen.dart';
import '/presentation/screens/register_page.dart';
import '/presentation/widgets/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController userValue = TextEditingController();
  TextEditingController passvalue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset("assets/images/logo.jpg", height: 80),
                ),
                Center(
                  child: const Text(
                    'Login to Your Account',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  cursorColor: primaryGreen,
                  controller: userValue,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'email is required';
                    } else if (!value.contains('@')) {
                      return 'enter valid email';
                    }
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
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: primaryGreen,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is required';
                    }
                    return null;
                  },
                  controller: passvalue,
                  obscureText: obscureText,
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: primaryGreen),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                      try {
                        await loginUser();

                        //User? user = FirebaseAuth.instance.currentUser;
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return MainHomeScreen();
                                },
                              ),
                            )
                            .then((value) {
                              userValue.clear();
                              passvalue.clear();
                            });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-credential') {
                          showSnakBar(
                            context,
                            'Email or password is incorrect.',
                          );
                        }
                        if (e.code == 'user-not-found') {
                                showSnakBar(
                                  context,
                                  'No user found for that email.',
                                );
                              }  if (e.code == 'wrong-password') {
                                showSnakBar(
                                  context,
                                  'Wrong password provided for that user.',
                                );}
                       
                      } 
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: primaryGreen),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userValue.text,
      password: passvalue.text,
    );
  }
}
