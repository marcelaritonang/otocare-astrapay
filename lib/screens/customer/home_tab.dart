import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import '../../theme/app_theme.dart';
import 'bengkel_tab.dart';

class HomeTab extends StatelessWidget {
  final Function(int)? onTabSwitch;

  const HomeTab({super.key, this.onTabSwitch});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildVehicleCard(context),
            const SizedBox(height: 16),
            _buildServiceReminder(context),
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

  Widget _buildVehicleCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => _showEditVehicleSheet(context),
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
              GestureDetector(
                onTap: () => _showEditVehicleSheet(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.edit_outlined, color: AppTheme.primaryBlue, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditVehicleSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _EditVehicleSheet(),
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

  Widget _buildServiceReminder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pengingat Service', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              GestureDetector(
                onTap: () {
                  // Switch to History tab (index 3)
                  if (onTabSwitch != null) {
                    onTabSwitch!(3);
                  }
                },
                child: Text('Lihat Semua', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
              ),
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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Bengkel tab
                    if (onTabSwitch != null) {
                      onTabSwitch!(1);
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Scaffold(body: BengkelTab())));
                    }
                  },
                  child: _actionCard(Icons.search_rounded, 'Cari\nBengkel', const Color(0xFF1565D8)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Bengkel tab for booking
                    if (onTabSwitch != null) {
                      onTabSwitch!(1);
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Scaffold(body: BengkelTab())));
                    }
                  },
                  child: _actionCard(Icons.calendar_month_rounded, 'Booking\nService', const Color(0xFF00BFA5)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showScanStrukSheet(context),
                  child: _actionCard(Icons.document_scanner_rounded, 'Scan\nStruk', const Color(0xFF7C4DFF)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Switch to History tab (index 3)
                    if (onTabSwitch != null) {
                      onTabSwitch!(3);
                    }
                  },
                  child: _actionCard(Icons.history_rounded, 'History\nService', const Color(0xFFFFA726)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showScanStrukSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _ScanStrukSheet(),
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
    final bengkelData = [
      {
        'name': 'AHASS Hero Motor',
        'address': 'Jl. Soekarno Hatta No. 680, Bandung',
        'rating': 4.3,
        'reviews': 312,
        'distance': '1.2 km',
        'isOpen': true,
        'services': ['Honda Specialist', 'Ganti Oli', 'Tune Up', 'Injeksi'],
        'promo': 'Diskon 15% Ganti Oli',
        'image': 'https://images.unsplash.com/photo-1636761358757-0a616eb9e17e?w=400&fit=crop',
        'priceRange': 'Rp 50rb - 500rb',
        'lat': -6.9537,
        'lng': 107.6566,
      },
      {
        'name': 'Yamaha Bahana Bandung',
        'address': 'Jl. Soekarno Hatta No. 417, Bandung',
        'rating': 4.2,
        'reviews': 189,
        'distance': '1.8 km',
        'isOpen': true,
        'services': ['Yamaha Specialist', 'CVT', 'Injeksi', 'V-Belt'],
        'promo': 'Cashback Rp50rb AstraPay',
        'image': 'https://images.unsplash.com/photo-1517524206127-48bbd363f3d7?w=400&fit=crop',
        'priceRange': 'Rp 75rb - 1.5jt',
        'lat': -6.9390,
        'lng': 107.6015,
      },
      {
        'name': 'GP Motor Bandung',
        'address': 'Jl. Gatot Subroto No. 205, Bandung',
        'rating': 4.5,
        'reviews': 156,
        'distance': '2.1 km',
        'isOpen': true,
        'services': ['All Brand', 'Bore Up', 'Overhaul', 'Kopling'],
        'promo': null,
        'image': 'https://images.unsplash.com/photo-1650569663338-f6921d483868?w=400&fit=crop',
        'priceRange': 'Rp 40rb - 600rb',
        'lat': -6.9218,
        'lng': 107.6275,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bengkel Terdekat', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              GestureDetector(
                onTap: () {
                  // Switch to Bengkel tab (index 1)
                  if (onTabSwitch != null) {
                    onTabSwitch!(1);
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Scaffold(body: BengkelTab())));
                  }
                },
                child: Text('Lihat Peta', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Map preview
          GestureDetector(
            onTap: () {
              if (onTabSwitch != null) {
                onTabSwitch!(1);
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Scaffold(body: BengkelTab())));
              }
            },
            child: ClipRRect(
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
                            // User location
                            Marker(point: LatLng(-6.9175, 107.6191), width: 24, height: 24,
                              child: Container(decoration: BoxDecoration(color: AppTheme.primaryBlue, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)))),
                            // AHASS Hero Motor - Jl. Soekarno Hatta 680
                            Marker(point: LatLng(-6.9537, 107.6566), width: 28, height: 28, child: const Icon(Icons.location_on, color: Color(0xFFE53935), size: 28)),
                            // Yamaha Bahana - Jl. Soekarno Hatta 417
                            Marker(point: LatLng(-6.9390, 107.6015), width: 28, height: 28, child: const Icon(Icons.location_on, color: Color(0xFF1565D8), size: 28)),
                            // GP Motor - Jl. Gatot Subroto 205
                            Marker(point: LatLng(-6.9218, 107.6275), width: 28, height: 28, child: const Icon(Icons.location_on, color: Color(0xFF43A047), size: 28)),
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
          ),
          const SizedBox(height: 12),
          // Bengkel list
          ...bengkelData.map((bengkel) => _bengkelCard(
            context: context,
            bengkel: bengkel,
            name: bengkel['name'] as String,
            rating: '${bengkel['rating']}',
            distance: bengkel['distance'] as String,
            services: (bengkel['services'] as List<String>).join(' • '),
            promo: bengkel['promo'] as String?,
          )),
        ],
      ),
    );
  }

  Widget _bengkelCard({
    required BuildContext context,
    required Map<String, dynamic> bengkel,
    required String name,
    required String rating,
    required String distance,
    required String services,
    String? promo,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BengkelDetailScreen(bengkel: bengkel)),
        );
      },
      child: Container(
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

/// Bottom sheet for Scan Struk (OCR receipt scanner UI)
class _ScanStrukSheet extends StatefulWidget {
  const _ScanStrukSheet();

  @override
  State<_ScanStrukSheet> createState() => _ScanStrukSheetState();
}

class _ScanStrukSheetState extends State<_ScanStrukSheet> {
  bool _isScanning = false;
  bool _hasResult = false;

  // Mock scan result
  final Map<String, String> _scanResult = {
    'bengkel': 'Bengkel Jaya Motor',
    'tanggal': '28 Mei 2026',
    'layanan': 'Ganti Oli + Filter',
    'biaya': 'Rp 185.000',
  };

  void _simulateScan() {
    setState(() => _isScanning = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _hasResult = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFE8EBF0), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          // Title with close button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const SizedBox(width: 36),
                const Expanded(
                  child: Text('Scan Struk Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark), textAlign: TextAlign.center),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(color: const Color(0xFFF7F8FC), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.close_rounded, size: 20, color: AppTheme.textDark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text('Arahkan kamera ke struk untuk menyimpan riwayat service', style: TextStyle(fontSize: 12, color: AppTheme.textGrey), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          // Camera frame
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _hasResult ? _buildScanResult() : _buildCameraFrame(),
            ),
          ),
          const SizedBox(height: 16),
          // Action button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isScanning
                    ? null
                    : _hasResult
                        ? () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Struk berhasil disimpan ke riwayat service'),
                                backgroundColor: AppTheme.successGreen,
                              ),
                            );
                          }
                        : _simulateScan,
                icon: Icon(
                  _hasResult ? Icons.check_circle : Icons.camera_alt_rounded,
                  size: 20,
                ),
                label: Text(
                  _isScanning
                      ? 'Memindai...'
                      : _hasResult
                          ? 'Simpan ke Riwayat'
                          : 'Ambil Foto',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hasResult ? AppTheme.successGreen : const Color(0xFF7C4DFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
              ),
            ),
          ),
          if (_hasResult) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _hasResult = false;
                    });
                  },
                  child: const Text('Scan Ulang', style: TextStyle(color: AppTheme.primaryBlue)),
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCameraFrame() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF7C4DFF).withOpacity(0.5), width: 2),
      ),
      child: Stack(
        children: [
          // Simulated camera background
          Center(
            child: _isScanning
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF7C4DFF)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Memindai struk...', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.document_scanner_rounded, color: Colors.white.withOpacity(0.4), size: 64),
                      const SizedBox(height: 12),
                      Text('Posisikan struk di dalam frame', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
                    ],
                  ),
          ),
          // Corner guides
          Positioned(top: 16, left: 16, child: _cornerGuide(true, true)),
          Positioned(top: 16, right: 16, child: _cornerGuide(true, false)),
          Positioned(bottom: 16, left: 16, child: _cornerGuide(false, true)),
          Positioned(bottom: 16, right: 16, child: _cornerGuide(false, false)),
        ],
      ),
    );
  }

  Widget _cornerGuide(bool isTop, bool isLeft) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _CornerPainter(isTop: isTop, isLeft: isLeft),
      ),
    );
  }

  Widget _buildScanResult() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.successGreen.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 36),
          ),
          const SizedBox(height: 16),
          const Text('Struk Terdeteksi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
          const SizedBox(height: 20),
          _resultRow(Icons.store_rounded, 'Bengkel', _scanResult['bengkel']!),
          const SizedBox(height: 12),
          _resultRow(Icons.calendar_today_rounded, 'Tanggal', _scanResult['tanggal']!),
          const SizedBox(height: 12),
          _resultRow(Icons.build_rounded, 'Layanan', _scanResult['layanan']!),
          const SizedBox(height: 12),
          _resultRow(Icons.payments_rounded, 'Biaya', _scanResult['biaya']!),
        ],
      ),
    );
  }

  Widget _resultRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom painter for corner guide marks in the scan frame
class _CornerPainter extends CustomPainter {
  final bool isTop;
  final bool isLeft;

  _CornerPainter({required this.isTop, required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7C4DFF)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (isTop && isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (isTop && !isLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!isTop && isLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Edit Vehicle Bottom Sheet ---
class _EditVehicleSheet extends StatefulWidget {
  const _EditVehicleSheet();

  @override
  State<_EditVehicleSheet> createState() => _EditVehicleSheetState();
}

class _EditVehicleSheetState extends State<_EditVehicleSheet> {
  final _namaController = TextEditingController(text: 'Honda Vario 160');
  final _platController = TextEditingController(text: 'D 1234 ABC');
  final _tahunController = TextEditingController(text: '2024');
  String _selectedWarna = 'Biru';
  String _selectedTipe = 'CBS';
  bool _saved = false;

  final List<String> _warnaOptions = ['Biru', 'Hitam', 'Merah', 'Putih', 'Abu-abu'];
  final List<String> _tipeOptions = ['CBS', 'ABS', 'ISS', 'Standard'];

  @override
  void dispose() {
    _namaController.dispose();
    _platController.dispose();
    _tahunController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFE8EBF0), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          // Header with close
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const SizedBox(width: 36),
                const Expanded(
                  child: Text('Edit Kendaraan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark), textAlign: TextAlign.center),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(color: const Color(0xFFF7F8FC), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.close_rounded, size: 20, color: AppTheme.textDark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle icon
                  Center(
                    child: Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.two_wheeler, color: AppTheme.primaryBlue, size: 44),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField('Nama Kendaraan', _namaController, Icons.two_wheeler),
                  const SizedBox(height: 16),
                  _buildTextField('Plat Nomor', _platController, Icons.confirmation_number_outlined),
                  const SizedBox(height: 16),
                  _buildTextField('Tahun', _tahunController, Icons.calendar_today_rounded),
                  const SizedBox(height: 16),
                  // Tipe dropdown
                  const Text('Tipe', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE8EBF0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedTipe,
                        isExpanded: true,
                        icon: const Icon(Icons.expand_more, color: AppTheme.textGrey),
                        items: _tipeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 14)))).toList(),
                        onChanged: (v) => setState(() => _selectedTipe = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Warna chips
                  const Text('Warna', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _warnaOptions.map((w) {
                      final isSelected = w == _selectedWarna;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedWarna = w),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryBlue : const Color(0xFFF7F8FC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: isSelected ? AppTheme.primaryBlue : const Color(0xFFE8EBF0)),
                          ),
                          child: Text(w, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : AppTheme.textDark)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _saved = true);
                  Future.delayed(const Duration(milliseconds: 800), () {
                    if (mounted) Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text('Kendaraan berhasil diperbarui'),
                          ],
                        ),
                        backgroundColor: AppTheme.successGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _saved
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 20),
                        SizedBox(width: 8),
                        Text('Tersimpan!', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      ],
                    )
                  : const Text('Simpan Perubahan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 20),
            filled: true,
            fillColor: const Color(0xFFF7F8FC),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE8EBF0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE8EBF0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          ),
        ),
      ],
    );
  }
}
