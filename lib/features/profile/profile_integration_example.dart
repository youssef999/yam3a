import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/res/app_colors.dart';
import 'package:shop_app/features/profile/profile_view.dart';

/// Example of how to integrate ProfileView into your app
/// This shows different navigation patterns

class ProfileIntegrationExample extends StatelessWidget {
  const ProfileIntegrationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Integration Examples'),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Example 1: Direct Navigation
          _buildExampleCard(
            title: '1. Direct Navigation',
            description: 'Navigate to profile from any screen',
            icon: Icons.arrow_forward,
            color: Colors.blue,
            onTap: () {
              Get.to(() => const ProfileView());
            },
          ),
          
          const SizedBox(height: 16),
          
          // Example 2: Bottom Navigation Integration
          _buildExampleCard(
            title: '2. Bottom Navigation',
            description: 'Use profile in bottom nav bar',
            icon: Icons.navigation,
            color: Colors.green,
            onTap: () {
              Get.to(() => const BottomNavExample());
            },
          ),
          
          const SizedBox(height: 16),
          
          // Example 3: Drawer Menu
          _buildExampleCard(
            title: '3. Drawer Menu',
            description: 'Add profile to side drawer',
            icon: Icons.menu,
            color: Colors.orange,
            onTap: () {
              Get.to(() => const DrawerExample());
            },
          ),
          
          const SizedBox(height: 16),
          
          // Example 4: Profile Settings Only
          _buildExampleCard(
            title: '4. Settings Dialog',
            description: 'Show quick settings options',
            icon: Icons.settings,
            color: Colors.purple,
            onTap: () {
              Get.to(() => const ProfileView());
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildExampleCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

/// Example 2: Bottom Navigation Integration
class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const Center(child: Text('Home Page')),
    const Center(child: Text('Services Page')),
    const Center(child: Text('Orders Page')),
    const ProfileView(), // Profile as 4th tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// Example 3: Drawer Integration
class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Example'),
        backgroundColor: primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, const Color(0xff8B4B89)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: Color(0xff5A1E3D)),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Services'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Orders'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.person, color: primaryColor),
              title: Text(
                'Profile & Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ProfileView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                // Logout logic
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Open drawer to see profile option'),
      ),
    );
  }
}
