
import 'package:flutter/material.dart';
import '/presentation/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == 2);
                  },
                  children: [
                    buildPage(
                      image: 'assets/images/onboarding1.jpeg',
                      title: 'Fast Delivery',
                      description:
                          'Get your food delivered to your doorstep quickly and safely.',
                    ),
                    buildPage(
                      image: 'assets/images/onboarding2.png',
                      title: 'Fresh Food',
                      description:
                          'We ensure your food is always fresh and delicious.',
                    ),
                    buildPage(
                      image: 'assets/images/onboarding33.png',
                      title: 'Easy Payment',
                      description:
                          'Pay securely and conveniently through our app.',
                    ),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect:  ExpandingDotsEffect(
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
              const SizedBox(height: 20),
              isLastPage
                  ? ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('seenOnboarding', true);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Get Started',style: TextStyle(fontSize: 18, color: Colors.white),),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('seenOnboarding', true);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(120, 50),
                          ),
                          child: const Text('Next',style: TextStyle(fontSize: 18, color: Colors.white),),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        const SizedBox(height: 30),
        Text(
          title,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
