import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildMotorInfo(),
            const SizedBox(height: 16),
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Andi Pratama', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('andi.pratama@email.com', style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text('AstraPay Member', style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.edit, color: Colors.white70, size: 20),
        ],
      ),
    );
  }

  Widget _buildMotorInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.two_wheeler, color: AppTheme.primaryBlue, size: 20),
              SizedBox(width: 8),
              Text('Motor Saya', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          const Divider(height: 20),
          _infoRow('Motor', 'Honda Vario 160 (2022)'),
          _infoRow('Plat', 'D 1234 ABC'),
          _infoRow('KM Saat Ini', '18.500 km'),
          _infoRow('Servis Terakhir', '15 Mar 2026'),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _menuItem(Icons.settings, 'Pengaturan', () {}),
        _menuItem(Icons.help_outline, 'Bantuan', () {}),
        _menuItem(Icons.info_outline, 'Tentang OtoCare', () {}),
        _menuItem(Icons.logout, 'Keluar', () {}),
      ],
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryBlue, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 14, color: AppTheme.textDark))),
            const Icon(Icons.chevron_right, color: AppTheme.textGrey, size: 20),
          ],
        ),
      ),
    );
  }
}
