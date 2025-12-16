
import 'package:flutter/material.dart';
import '../../data/services/home_services.dart';
import '../widgets/custom_munue_card.dart';
import '/data/models/menu_item.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _query = value.trim().toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _query.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          )
                              : null,
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),


              _query.isEmpty ? _buildSuggestions() : _buildSearchResults(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Recent Searches'),
        _buildChips([
          'Italian Pizza',
          'Burger King',
          'Salad',
          'Vegetarian',
          'Dessert',
          'Pancakes',
        ]),

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

        _buildSectionTitle('All Cuisines'),
        _buildChips([
          'Bakery & Cake',
          'Dessert',
          'Pizza',
        ]),
      ],
    );
  }


  Widget _buildSearchResults() {
    return StreamBuilder<List<MenuItem>>(
      stream: HomeServices.getMenuItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('No menu items found'),
          );
        }

        final results = snapshot.data!
            .where((item) =>
            item.name.toLowerCase().contains(_query))
            .toList();

        if (results.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('No matching food found'),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CustomMunueCard(
                foodName: item.name,
                foodImage: item.imageUrl,
                foodDetails: item.description,
                foodPrice: '\$${item.price}',
                menuItem: item,
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildChips(List<String> labels) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: labels.map((label) {
          return Chip(
            label: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            shape: StadiumBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            backgroundColor: Colors.transparent,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}


