import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/presentation/screens/login_page.dart';
import '/logic/cubit/user_cubit.dart';
import '/logic/cubit/user_state.dart';

// Navigation Imports
import '/presentation/screens/edit_profile_screen.dart';
import '/presentation/screens/address_screen.dart';
import '/presentation/screens/notification_screen.dart';
import '/presentation/screens/language_screen.dart';
import '/presentation/screens/payment_methods_screen.dart';
import '/presentation/screens/favorite_restaurants_screen.dart';
import '/presentation/screens/offers_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/presentation/theme/theme_manager.dart';
import 'main_home_screen.dart'; // For Logout logic

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Helper to check current theme
  bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  void initState() {
    super.initState();
    // Load User Data
    context.read<UserCubit>().getCurrentUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        String userName = "Guest User";
        String userPhone = "No phone linked";

        if (state is UserLoaded) {
          userName = state.user.name;
          userPhone = state.user.phone.toString();
        }

        return Scaffold(
          // --- FIX: Transparent AppBar ---
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('Profile'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainHomeScreen()),
                      (route) => false,
                );
              },
            ),

            backgroundColor: Colors.transparent, // Makes it see-through
            elevation: 0,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- FIX: SafeArea for Header ---
                  SafeArea(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.person, size: 40, color: Colors.grey),
                      ),
                      title: Text(
                        userName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(userPhone),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Menu Items ---
                  _buildMenuTile(
                    context,
                    icon: Icons.favorite_outline,
                    title: 'My Favorite Foods',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteRestaurantsScreen())),
                  ),
                  _buildMenuTile(
                    context,
                    icon: Icons.local_offer_outlined,
                    title: 'Special Offers & Promo',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OffersScreen())),
                  ),
                  _buildMenuTile(
                    context,
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Payment Methods',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethodsScreen())),
                  ),
                  const Divider(),

                  _buildMenuTile(
                    context,
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
                  ),
                  _buildMenuTile(
                    context,
                    icon: Icons.location_on_outlined,
                    title: 'Address',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen())),
                  ),
                  _buildMenuTile(
                    context,
                    icon: Icons.notifications_none_outlined,
                    title: 'Notification',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen())),
                  ),
                  _buildMenuTile(
                    context,
                    icon: Icons.language,
                    title: 'Language',
                    trailingText: 'English (US)',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageScreen())),
                  ),

                  // --- FIX: Dark Mode Switch ---
                  _buildMenuTile(
                    context,
                    icon: Icons.visibility_outlined,
                    title: 'Dark Mode',
                    onTap: () {
                      bool isCurrentlyDark = _isDarkMode(context);
                      ThemeManager.toggleTheme(!isCurrentlyDark);
                    },
                    trailingWidget: Switch(
                      value: _isDarkMode(context),
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        ThemeManager.toggleTheme(value);
                      },
                    ),
                  ),

                  // Logout
                  _buildMenuTile(
                    context,
                    icon: Icons.logout,
                    title: 'Logout',
                    isRed: true,
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- HELPER WIDGET (UPDATED) ---
  Widget _buildMenuTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
        String? trailingText,
        Widget? trailingWidget, // Can now accept a Switch
        bool isRed = false,
      }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, color: isRed ? Colors.red : null),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isRed ? Colors.red : null)),
      trailing: trailingWidget ?? ( // Use trailingWidget if provided
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailingText != null) Text(trailingText, style: const TextStyle(fontSize: 14)),
              if (trailingText != null) const SizedBox(width: 8),
              // Only show arrow if it's not a text, switch, or logout
              if (!isRed && trailingText == null) const Icon(Icons.chevron_right, size: 20),
            ],
          )
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          child: Column(
            children: [
              const Text('Logout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(height: 16),
              const Text('Are you sure you want to log out?'),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () async {
                        // --- FIX: REAL LOGOUT ---
                        Navigator.pop(context); // Close dialog
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                                (route) => false,
                          );
                        }
                      },

                      child: const Text('Yes, Logout', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}