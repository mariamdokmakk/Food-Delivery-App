
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController(
    text: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Search Bar Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    // ✅ FIX: use Expanded
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () => _searchController.clear(),
                          ),
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:  BorderSide(color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 🔹 Recent Searches Section
              _buildSectionTitle('Recent Searches'),
              _buildChips([
                'Italian Pizza',
                'Burger King',
                'Salad',
                'Vegetarian',
                'Dessert',
                'Pancakes',
              ]),

              // 🔹 Popular Cuisines Section
              _buildSectionTitle('Popular Cuisines'),
              _buildChips([
                'Breakfast',
                'Snack',
                'Fast Food',
                'Beverages',
                'Chicken',
                'Noodles',
                'Rice',
                'Seafood',
                'International',
              ]),

              // 🔹 All Cuisines Section
              _buildSectionTitle('All Cuisines'),
              _buildChips([
                'Bakery & Cake',
                'Dessert',
                'Pizza',
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChips(List<String> labels) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: labels.map((label) => _buildChip(label)).toList(),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label, style:  TextStyle(color:  Theme.of(context).colorScheme.primary)),
      shape:  StadiumBorder(side: BorderSide(color:  Theme.of(context).colorScheme.primary)),
      backgroundColor: Colors.transparent,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
