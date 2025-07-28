import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../providers/cart_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Consumer<AuthService>(
              builder: (context, authService, child) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.blue.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue.shade200,
                        child: Text(
                          authService.currentUserProfile?.name != null
                              ? authService.currentUserProfile!.name
                                  .substring(0, 1)
                                  .toUpperCase()
                              : authService.currentUser?.email
                                      ?.substring(0, 1)
                                      .toUpperCase() ??
                                  'U',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        authService.currentUserProfile?.name ??
                            authService.currentUser?.email ??
                            'User',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authService.currentUser?.email ?? 'No email',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      if (authService.currentUserProfile?.address != null &&
                          authService.currentUserProfile!.address.isNotEmpty &&
                          authService.currentUserProfile!.address !=
                              'Not provided') ...[
                        const SizedBox(height: 4),
                        Text(
                          authService.currentUserProfile!.address,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Contact Information
            Consumer<AuthService>(
              builder: (context, authService, child) {
                final profile = authService.currentUserProfile;
                if (profile != null &&
                    (profile.contactNumber != 'Not provided' ||
                        profile.address != 'Not provided')) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (profile.contactNumber != 'Not provided')
                        _buildInfoCard(
                          'Phone Number',
                          profile.contactNumber,
                          Icons.phone,
                          Colors.green,
                        ),
                      if (profile.contactNumber != 'Not provided' &&
                          profile.address != 'Not provided')
                        const SizedBox(height: 12),
                      if (profile.address != 'Not provided')
                        _buildInfoCard(
                          'Address',
                          profile.address,
                          Icons.location_on,
                          Colors.red,
                        ),
                      const SizedBox(height: 24),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Shopping Stats
            const Text(
              'Shopping Stats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Cart Items',
                        '${cart.itemCount}',
                        Icons.shopping_cart,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Total Value',
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        Icons.attach_money,
                        Colors.green,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Account Options
            const Text(
              'Account Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildOptionCard(
              'Order History',
              'View your past orders',
              Icons.history,
              () => _showOrderHistory(context),
            ),
            const SizedBox(height: 12),

            _buildOptionCard(
              'Wishlist',
              'Manage your favorite items',
              Icons.favorite,
              () => _showWishlist(context),
            ),
            const SizedBox(height: 12),

            _buildOptionCard(
              'Account Settings',
              'Update your preferences',
              Icons.settings,
              () => _showAccountSettings(context),
            ),
            const SizedBox(height: 12),

            _buildOptionCard(
              'Help & Support',
              'Get help with your account',
              Icons.help,
              () => _showSupport(context),
            ),
            const SizedBox(height: 32),

            // Sign Out Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _signOut(context),
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
      String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showOrderHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order History'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Order #1001'),
              subtitle: Text('Delivered - \$99.99'),
            ),
            ListTile(
              leading: Icon(Icons.local_shipping, color: Colors.orange),
              title: Text('Order #1002'),
              subtitle: Text('Shipping - \$149.99'),
            ),
            ListTile(
              leading: Icon(Icons.pending, color: Colors.blue),
              title: Text('Order #1003'),
              subtitle: Text('Processing - \$79.99'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showWishlist(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Wishlist'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Wireless Headphones'),
              subtitle: Text('\$129.99'),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Gaming Mouse'),
              subtitle: Text('\$59.99'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAccountSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              subtitle: Text('Manage your notification preferences'),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Privacy & Security'),
              subtitle: Text('Update your security settings'),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment Methods'),
              subtitle: Text('Manage your payment options'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Live Chat'),
              subtitle: Text('Chat with our support team'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Support'),
              subtitle: Text('support@ecommerce.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone Support'),
              subtitle: Text('+1 (555) 123-4567'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.signOut();
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed out successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
