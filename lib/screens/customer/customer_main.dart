import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'home_tab.dart';
import 'bengkel_tab.dart';
import 'history_tab.dart';
import 'reminder_tab.dart';
import 'profile_tab.dart';

class CustomerMain extends StatefulWidget {
  const CustomerMain({super.key});

  @override
  State<CustomerMain> createState() => _CustomerMainState();
}

class _CustomerMainState extends State<CustomerMain> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeTab(),
    BengkelTab(),
    SizedBox(), // placeholder for QR
    HistoryTab(),
    ReminderTab(),
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
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.home_filled, 'Home'),
              _navItem(1, Icons.build_circle_outlined, 'Bengkel'),
              _centerButton(),
              _navItem(3, Icons.receipt_long_outlined, 'History'),
              _navItem(4, Icons.notifications_outlined, 'Reminder'),
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
              fontSize: 11,
              color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _centerButton() {
    return GestureDetector(
      onTap: () => _showQRPayment(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryBlue.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, color: Colors.white, size: 24),
            Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _showQRPayment() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryBlue, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.qr_code_2, size: 150, color: AppTheme.primaryBlue),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Scan QR untuk Bayar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Arahkan kamera ke QRIS bengkel', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
