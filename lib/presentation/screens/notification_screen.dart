import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // State variables for the switches
  bool _generalNotification = true;
  bool _sound = true;
  bool _vibrate = false;
  bool _specialOffers = true;
  bool _promoDiscount = false;
  bool _payments = true;
  bool _cashback = false;
  bool _appUpdates = true;
  bool _newServiceAvailable = false;
  bool _newTipsAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSwitchTile('General Notification', _generalNotification, (val) {
                setState(() => _generalNotification = val);
              }),
              _buildSwitchTile('Sound', _sound, (val) {
                setState(() => _sound = val);
              }),
              _buildSwitchTile('Vibrate', _vibrate, (val) {
                setState(() => _vibrate = val);
              }),

              const SizedBox(height: 16), // Spacer

              _buildSwitchTile('Special Offers', _specialOffers, (val) {
                setState(() => _specialOffers = val);
              }),
              _buildSwitchTile('Promo & Discount', _promoDiscount, (val) {
                setState(() => _promoDiscount = val);
              }),
              _buildSwitchTile('Payments', _payments, (val) {
                setState(() => _payments = val);
              }),
              _buildSwitchTile('Cashback', _cashback, (val) {
                setState(() => _cashback = val);
              }),
              _buildSwitchTile('App Updates', _appUpdates, (val) {
                setState(() => _appUpdates = val);
              }),
              _buildSwitchTile('New Service Available', _newServiceAvailable, (val) {
                setState(() => _newServiceAvailable = val);
              }),
              _buildSwitchTile('New Tips Available', _newTipsAvailable, (val) {
                setState(() => _newTipsAvailable = val);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        activeThumbColor: Theme.of(context).primaryColor,
        onChanged: onChanged,
      ),
    );
  }
}