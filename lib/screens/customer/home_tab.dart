import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
            _buildVehicleCard(),
            const SizedBox(height: 16),
            _buildServiceReminder(),
            const SizedBox(height: 20),
            _buildQuickActions(context),
            const SizedBox(height: 20),
            _buildNearbyBengkel(context),
            const SizedBox(height: 20),
            _buildPromoSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.two_wheeler, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('OtoCare', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('by AstraPay', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Greeting
          Text('Halo, Marcel! 👋', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(
            'Jaga motor kamu tetap prima',
            style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 12),
          ),
          const SizedBox(height: 16),
          // Saldo mini card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text('Saldo AstraPay', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                const SizedBox(width: 8),
                const Text('Rp 5.000.000', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Top Up', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.two_wheeler, color: AppTheme.primaryBlue, size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Honda Vario 160', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  const SizedBox(height: 2),
                  Text('D 1234 ABC', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _vehicleTag('2024'),
                      const SizedBox(width: 6),
                      _vehicleTag('CBS'),
                      const SizedBox(width: 6),
                      _vehicleTag('Biru'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.edit_outlined, color: AppTheme.primaryBlue, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: const TextStyle(fontSize: 10, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildServiceReminder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pengingat Service', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              Text('Lihat Semua', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 10),
          _reminderCard(
            icon: Icons.water_drop_rounded,
            title: 'Ganti Oli',
            subtitle: 'Terakhir: 15 Mar 2026',
            daysLeft: 5,
            color: const Color(0xFFFF6B6B),
            isUrgent: true,
          ),
          _reminderCard(
            icon: Icons.settings_rounded,
            title: 'Tune Up',
            subtitle: 'Terakhir: 20 Jan 2026',
            daysLeft: 40,
            color: AppTheme.successGreen,
            isUrgent: false,
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
    required bool isUrgent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: isUrgent ? Border.all(color: color.withOpacity(0.3), width: 1) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isUrgent) Icon(Icons.warning_rounded, color: color, size: 12),
                if (isUrgent) const SizedBox(width: 3),
                Text(
                  '$daysLeft hari',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Layanan OtoCare', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _actionCard(Icons.search_rounded, 'Cari\nBengkel', const Color(0xFF1565D8))),
              const SizedBox(width: 10),
              Expanded(child: _actionCard(Icons.calendar_month_rounded, 'Booking\nService', const Color(0xFF00BFA5))),
              const SizedBox(width: 10),
              Expanded(child: _actionCard(Icons.document_scanner_rounded, 'Scan\nStruk', const Color(0xFF7C4DFF))),
              const SizedBox(width: 10),
              Expanded(child: _actionCard(Icons.history_rounded, 'History\nService', const Color(0xFFFFA726))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionCard(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: AppTheme.textDark, fontWeight: FontWeight.w500, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyBengkel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bengkel Terdekat', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              Text('Lihat Peta', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          // Map preview
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 130,
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(-6.9175, 107.6191),
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.otocare.astrapay',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(point: LatLng(-6.9175, 107.6191), width: 24, height: 24,
                            child: Container(decoration: BoxDecoration(color: AppTheme.primaryBlue, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)))),
                          Marker(point: LatLng(-6.9210, 107.6250), width: 28, height: 28, child: const Icon(Icons.location_on, color: Color(0xFFE53935), size: 28)),
                          Marker(point: LatLng(-6.9140, 107.6130), width: 28, height: 28, child: const Icon(Icons.location_on, color: Color(0xFF43A047), size: 28)),
                          Marker(point: LatLng(-6.9200, 107.6100), width: 28, height: 28, child: const Icon(Icons.location_on, color: Color(0xFFFB8C00), size: 28)),
                        ],
                      ),
                    ],
                  ),
                  // Overlay label
                  Positioned(
                    top: 10, left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.near_me, color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text('3 bengkel di sekitarmu', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Bengkel list
          _bengkelCard(
            name: 'Bengkel Jaya Motor',
            rating: '4.8',
            distance: '1.2 km',
            services: 'Ganti Oli • Tune Up • Servis Berkala',
            promo: 'Diskon 15%',
          ),
          _bengkelCard(
            name: 'Mitra Motor Sejahtera',
            rating: '4.6',
            distance: '1.8 km',
            services: 'All Brand • Overhaul • Elektrikal',
            promo: 'Cashback Rp50rb',
          ),
          _bengkelCard(
            name: 'Bengkel Pak Budi',
            rating: '4.5',
            distance: '2.1 km',
            services: 'Honda Specialist • Rem • Rantai',
            promo: null,
          ),
        ],
      ),
    );
  }

  Widget _bengkelCard({
    required String name,
    required String rating,
    required String distance,
    required String services,
    String? promo,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryBlue.withOpacity(0.1), AppTheme.primaryBlue.withOpacity(0.05)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.build_rounded, color: AppTheme.primaryBlue, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark))),
                    if (promo != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                        child: Text(promo, style: const TextStyle(fontSize: 9, color: AppTheme.successGreen, fontWeight: FontWeight.w600)),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                    const SizedBox(width: 2),
                    Text(rating, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    const SizedBox(width: 10),
                    Icon(Icons.location_on_rounded, color: AppTheme.textGrey, size: 12),
                    const SizedBox(width: 2),
                    Text(distance, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(services, style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue.withOpacity(0.7)), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.primaryBlue, size: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Promo OtoCare', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _promoCard(
                  title: 'Cashback 50%',
                  desc: 'Service pertama via OtoCare',
                  color: AppTheme.primaryBlue,
                  icon: Icons.percent_rounded,
                ),
                _promoCard(
                  title: 'Gratis Oli',
                  desc: 'Booking 3x dapat oli gratis',
                  color: const Color(0xFF7C4DFF),
                  icon: Icons.card_giftcard_rounded,
                ),
                _promoCard(
                  title: 'Voucher Rp25rb',
                  desc: 'Ajak teman pakai OtoCare',
                  color: const Color(0xFF00BFA5),
                  icon: Icons.people_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoCard({
    required String title,
    required String desc,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white.withOpacity(0.8), size: 18),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                child: const Text('PROMO', style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 3),
          Text(desc, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.85)), maxLines: 2),
        ],
      ),
    );
  }
}
