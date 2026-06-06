import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'home_tab.dart';
import 'bengkel_tab.dart';
import 'history_tab.dart';
import 'reminder_tab.dart';

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
      backgroundColor: const Color(0xFFF7F8FC),
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
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.home_rounded, 'Home'),
              _navItem(1, Icons.search_rounded, 'Bengkel'),
              _centerButton(),
              _navItem(3, Icons.receipt_long_rounded, 'Riwayat'),
              _navItem(4, Icons.notifications_rounded, 'Reminder'),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryBlue.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? AppTheme.primaryBlue : const Color(0xFFB0B7C3), size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? AppTheme.primaryBlue : const Color(0xFFB0B7C3),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerButton() {
    return GestureDetector(
      onTap: () => _showQRPayment(),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryBlue.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 22),
            Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _showQRPayment() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFE8EBF0), borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FC),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.3), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.qr_code_2_rounded, size: 140, color: AppTheme.primaryBlue),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Scan QR untuk Bayar', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            const SizedBox(height: 6),
            const Text('Arahkan kamera ke QRIS bengkel', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, color: AppTheme.successGreen, size: 14),
                  const SizedBox(width: 4),
                  Text('Dilindungi AstraPay', style: TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
