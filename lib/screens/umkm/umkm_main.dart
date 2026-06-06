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
  final int _pendingBookingCount = 3;

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
      floatingActionButton: _buildHelpButton(context),
    );
  }

  Widget _buildHelpButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showHelpSheet(context),
      backgroundColor: AppTheme.primaryBlue,
      elevation: 6,
      icon: const Icon(Icons.headset_mic_rounded, color: Colors.white, size: 20),
      label: const Text(
        'Bantuan',
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showHelpSheet(BuildContext context) {
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
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.headset_mic_rounded, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pusat Bantuan OtoCare',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ada kendala atau pertanyaan? Tim kami siap membantu Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.5),
            ),
            const SizedBox(height: 24),
            _helpOption(ctx, Icons.chat_bubble_outline, 'Live Chat', 'Respon dalam 5 menit'),
            const SizedBox(height: 12),
            _helpOption(ctx, Icons.phone_outlined, 'Telepon', '021-1500-888'),
            const SizedBox(height: 12),
            _helpOption(ctx, Icons.email_outlined, 'Email', 'support@otocare.id'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _helpOption(BuildContext ctx, IconData icon, String title, String subtitle) {
    return InkWell(
      onTap: () {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Menghubungkan ke $title...'),
            backgroundColor: AppTheme.primaryBlue,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textGrey),
          ],
        ),
      ),
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
              _navItem(0, Icons.calendar_today_rounded, 'Booking', badgeCount: _pendingBookingCount),
              _navItem(1, Icons.menu_book_rounded, 'Katalog'),
              _navItem(2, Icons.account_balance_wallet_rounded, 'Keuangan'),
              _navItem(3, Icons.star_rounded, 'Ulasan'),
              _navItem(4, Icons.store_rounded, 'Profil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label, {int badgeCount = 0}) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 14 : 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryBlue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey,
                  size: 22,
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -8,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
