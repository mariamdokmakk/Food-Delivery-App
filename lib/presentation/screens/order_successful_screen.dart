import 'package:flutter/material.dart';
import 'main_home_screen.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Big Green Success Icon
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 32),

            // 2. Success Text
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your order has been placed successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            // 3. Buttons
            // "Track Order" (We didn't build the map screen, so this can just print to console)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Tracking feature coming soon!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                    'Track Order',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ),
            ),
            const SizedBox(height: 16),

            // "Continue Ordering" - Goes back to the Restaurant
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  // Remove all history and go back to the Home page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      MainHomeScreen(),
                    ),
                        (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Continue Ordering',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}