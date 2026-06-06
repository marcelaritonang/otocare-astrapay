import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'appointment_tab.dart';
import 'profile_umkm_tab.dart';
import 'katalog_tab.dart';
import 'rating_tab.dart';
import 'income_tab.dart';

class UmkmMain extends StatefulWidget {
  const UmkmMain({super.key});

  @override
  State<UmkmMain> createState() => _UmkmMainState();
}

class _UmkmMainState extends State<UmkmMain> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    AppointmentTab(),
    KatalogTab(),
    IncomeTab(),
    RatingTab(),
    ProfileUmkmTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.calendar_today, 'Booking'),
              _navItem(1, Icons.menu_book, 'Katalog'),
              _navItem(2, Icons.account_balance_wallet, 'Pendapatan'),
              _navItem(3, Icons.star_outline, 'Rating'),
              _navItem(4, Icons.store, 'Profil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
