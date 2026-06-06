import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'bengkel_tab.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildBalanceCard(),
            const SizedBox(height: 16),
            _buildReminderCards(),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            const SizedBox(height: 16),
            _buildNearbyBengkel(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.two_wheeler, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('OtoCare', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('by AstraPay', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ]),
              Row(children: [
                _headerIcon(Icons.notifications_outlined),
                const SizedBox(width: 10),
                _headerIcon(Icons.person_outline),
              ]),
            ],
          ),
          const SizedBox(height: 16),
          Text('Halo, Andi! 👋', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            'Motor kamu butuh service dalam 5 hari',
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Saldo AstraPay', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                  const SizedBox(height: 4),
                  const Text('Rp 2.450.000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  Row(children: [
                    _balanceAction(Icons.add, 'Top Up'),
                    const SizedBox(width: 16),
                    _balanceAction(Icons.swap_horiz, 'Transfer'),
                    const SizedBox(width: 16),
                    _balanceAction(Icons.history, 'Riwayat'),
                  ]),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Icon(Icons.stars, color: AppTheme.successGreen, size: 20),
                  SizedBox(height: 2),
                  Text('1.250', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.successGreen)),
                  Text('Points', style: TextStyle(fontSize: 9, color: AppTheme.successGreen)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 16),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
      ],
    );
  }

  Widget _buildReminderCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pengingat Service', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 10),
          _reminderCard(
            icon: Icons.oil_barrel,
            title: 'Ganti Oli',
            subtitle: 'Terakhir: 15 Mar 2026 · Berikutnya: 15 Jun 2026',
            daysLeft: 5,
            color: AppTheme.warningOrange,
          ),
          _reminderCard(
            icon: Icons.disc_full,
            title: 'Kampas Rem',
            subtitle: 'Terakhir: 20 Jan 2026 · Berikutnya: 20 Jul 2026',
            daysLeft: 40,
            color: AppTheme.successGreen,
          ),
        ],
      ),
    );
  }

  Widget _reminderCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required int daysLeft,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Text(
              '$daysLeft hari',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Layanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _serviceItem(Icons.search, 'Cari\nBengkel', AppTheme.primaryBlue),
              _serviceItem(Icons.camera_alt, 'Scan\nStruk', AppTheme.accentPink),
              _serviceItem(Icons.calendar_today, 'Booking\nService', AppTheme.successGreen),
              _serviceItem(Icons.history, 'History\nService', AppTheme.warningOrange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56, height: 56,
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppTheme.textDark, height: 1.3)),
      ],
    );
  }

  Widget _buildNearbyBengkel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bengkel Terdekat', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              Text('Lihat Semua', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          // Map placeholder
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
              image: const DecorationImage(
                image: NetworkImage('https://api.mapbox.com/styles/v1/mapbox/streets-v12/static/106.845,-6.208,13,0/400x200?access_token=placeholder'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppTheme.primaryBlue.withOpacity(0.05),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 40, color: AppTheme.primaryBlue.withOpacity(0.5)),
                        const SizedBox(height: 4),
                        Text('Peta Bengkel Sekitar', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ),
                // Fake pins
                Positioned(top: 30, left: 80, child: Icon(Icons.location_on, color: Colors.red.shade700, size: 24)),
                Positioned(top: 50, right: 60, child: Icon(Icons.location_on, color: AppTheme.primaryBlue, size: 24)),
                Positioned(bottom: 40, left: 150, child: Icon(Icons.location_on, color: AppTheme.successGreen, size: 24)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _bengkelMiniCard('Bengkel Jaya Motor', '⭐ 4.8 · 1.2 km', 'Ganti Oli, Tune Up, Servis Berkala'),
          _bengkelMiniCard('Mitra Motor Sejahtera', '⭐ 4.6 · 1.8 km', 'All Brand, Overhaul, Elektrikal'),
          _bengkelMiniCard('Bengkel Pak Budi', '⭐ 4.5 · 2.1 km', 'Motor Honda, Ganti Oli, Rem'),
        ],
      ),
    );
  }

  Widget _bengkelMiniCard(String name, String meta, String services) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.build, color: AppTheme.primaryBlue, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                Text(meta, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                Text(services, style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue.withOpacity(0.8))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.textGrey, size: 20),
        ],
      ),
    );
  }
}
