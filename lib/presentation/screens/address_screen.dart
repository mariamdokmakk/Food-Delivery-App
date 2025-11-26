import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/presentation/screens/set_location.dart';
import '/logic/cubit/user_cubit.dart';
import '/logic/cubit/user_state.dart';


class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    // 1. Trigger loading addresses when screen opens
    context.read<UserCubit>().loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SetLocationScreen()),
            );
          },
          child: const Text('Add New Address'),
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) =>
        current is UserAddressLoaded || current is UserLoading || current is UserError,
        builder: (context, state) {
          // --- Loading State ---
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // --- Error State ---
          if (state is UserError) {
            return Center(child: Text(state.message));
          }

          // --- Success State ---
          if (state is UserAddressLoaded) {
            if (state.addresses.isEmpty) {
              return const Center(child: Text("No addresses found. Add one!"));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.addresses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final address = state.addresses[index];
                return _buildAddressCard(
                  context,
                  title: address.label,
                  address: address.description,

                  // isDefault: index == 0,
                );
              },
            );
          }

          // Default empty state
          return const Center(child: Text("Loading addresses..."));
        },
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context,
      {required String title, required String address, bool isDefault = false}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? []
            : [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            // if (isDefault) const SizedBox(width: 8),
            // if (isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Default',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            address,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
          onPressed: () {
            // TODO: Edit Address Logic
          },
        ),
      ),
    );
  }
}