import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

class BengkelTab extends StatefulWidget {
  const BengkelTab({super.key});

  @override
  State<BengkelTab> createState() => _BengkelTabState();
}

class _BengkelTabState extends State<BengkelTab> {
  int _selectedCategory = 0;
  final List<String> _categories = ['Semua', 'Terdekat', 'Rating', 'Promo'];

  final List<Map<String, dynamic>> _bengkelList = [
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
      'whatsapp': '6281234567890',
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
      'whatsapp': '6281298765432',
      'lat': -6.9390,
      'lng': 107.6015,
    },
    {
      'name': 'GP Motor Bandung',
      'address': 'Jl. Gatot Subroto No. 205, Bandung',
      'rating': 4.5,
      'reviews': 256,
      'distance': '2.1 km',
      'isOpen': true,
      'services': ['All Brand', 'Bore Up', 'Overhaul', 'Kopling'],
      'promo': null,
      'image': 'https://images.unsplash.com/photo-1650569663338-f6921d483868?w=400&fit=crop',
      'priceRange': 'Rp 40rb - 600rb',
      'whatsapp': '6285712345678',
      'lat': -6.9218,
      'lng': 107.6275,
    },
    {
      'name': 'AHASS Ria Motor',
      'address': 'Jl. Soekarno Hatta No. 620, Bandung',
      'rating': 4.1,
      'reviews': 178,
      'distance': '3.0 km',
      'isOpen': false,
      'services': ['Honda Specialist', 'Servis Berkala', 'Rem', 'Rantai'],
      'promo': 'Free Check-up 10 Titik',
      'image': 'https://images.unsplash.com/photo-1578474005126-89909099fed6?w=400&fit=crop',
      'priceRange': 'Rp 45rb - 500rb',
      'whatsapp': '6281345678901',
      'lat': -6.9471,
      'lng': 107.6378,
    },
    {
      'name': 'Yamaha Arista',
      'address': 'Jl. Soekarno Hatta No. 717, Bandung',
      'rating': 4.3,
      'reviews': 145,
      'distance': '3.5 km',
      'isOpen': true,
      'services': ['Yamaha Specialist', 'Tune Up', 'Injeksi', 'Oli'],
      'promo': 'Gratis Nitrogen',
      'image': 'https://images.unsplash.com/photo-1581858544302-c40e2254ff87?w=400&fit=crop',
      'priceRange': 'Rp 50rb - 800rb',
      'whatsapp': '6282112345678',
      'lat': -6.9555,
      'lng': 107.6620,
    },
    {
      'name': 'Bengkel TOP 1 Lombok Motor',
      'address': 'Jl. Lombok No. 11S, Bandung',
      'rating': 4.4,
      'reviews': 203,
      'distance': '4.0 km',
      'isOpen': true,
      'services': ['All Brand', 'Ganti Oli', 'Tune Up', 'Elektrikal'],
      'promo': 'Paket Hemat Rp 99rb',
      'image': 'https://images.unsplash.com/photo-1604260324056-45f7c778754a?w=400&fit=crop',
      'priceRange': 'Rp 35rb - 400rb',
      'whatsapp': '6289876543210',
      'lat': -6.9105,
      'lng': 107.6045,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildCategoryFilter(),
          _buildMapPreview(),
          Expanded(child: _buildBengkelGrid()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Cari Bengkel', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text('Bandung', style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppTheme.textGrey, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari bengkel, layanan, atau brand...',
                  hintStyle: TextStyle(color: AppTheme.textLight, fontSize: 13),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.tune, color: AppTheme.primaryBlue, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = _selectedCategory == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _selectedCategory = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryBlue : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? AppTheme.primaryBlue : AppTheme.textLight.withOpacity(0.3)),
                  ),
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : AppTheme.textGrey,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMapPreview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => _showFullMap(),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: FlutterMap(
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
                        Marker(point: LatLng(-6.9175, 107.6191), width: 20, height: 20, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: AppTheme.primaryBlue, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3), boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.3), blurRadius: 8)]))),
                        Marker(point: LatLng(-6.9537, 107.6566), width: 30, height: 30, child: Icon(Icons.location_on, color: Colors.red.shade700, size: 24)),
                        Marker(point: LatLng(-6.9390, 107.6015), width: 30, height: 30, child: Icon(Icons.location_on, color: AppTheme.primaryBlue, size: 24)),
                        Marker(point: LatLng(-6.9218, 107.6275), width: 30, height: 30, child: Icon(Icons.location_on, color: AppTheme.successGreen, size: 24)),
                        Marker(point: LatLng(-6.9471, 107.6378), width: 30, height: 30, child: Icon(Icons.location_on, color: AppTheme.warningOrange, size: 24)),
                        Marker(point: LatLng(-6.9555, 107.6620), width: 30, height: 30, child: Icon(Icons.location_on, color: Colors.purple, size: 24)),
                        Marker(point: LatLng(-6.9105, 107.6045), width: 30, height: 30, child: Icon(Icons.location_on, color: Colors.teal, size: 24)),
                      ],
                    ),
                  ],
                ),
              ),
              // Label
              Positioned(
                bottom: 8, right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.fullscreen, size: 14, color: AppTheme.primaryBlue),
                      const SizedBox(width: 4),
                      Text('Buka Peta', style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              // Bengkel count
              Positioned(
                top: 8, left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(8)),
                  child: const Text('5 bengkel ditemukan', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mapPin(Color color) {
    return Icon(Icons.location_on, color: color, size: 22);
  }

  void _showFullMap() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => _FullMapScreen(bengkelList: _bengkelList)));
  }

  Widget _buildBengkelGrid() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _bengkelList.length,
      itemBuilder: (context, index) => _buildBengkelCard(_bengkelList[index]),
    );
  }

  Widget _buildBengkelCard(Map<String, dynamic> bengkel) {
    return GestureDetector(
      onTap: () => _showBengkelDetail(bengkel),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 56, height: 56,
                    child: Image.network(
                      bengkel['image'] ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                        child: const Icon(Icons.build, color: AppTheme.primaryBlue, size: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(bengkel['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: bengkel['isOpen'] ? AppTheme.successGreen.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              bengkel['isOpen'] ? 'Buka' : 'Tutup',
                              style: TextStyle(fontSize: 10, color: bengkel['isOpen'] ? AppTheme.successGreen : Colors.red, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(bengkel['address'], style: const TextStyle(fontSize: 11, color: AppTheme.textGrey), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 2),
                          Text('${bengkel['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          Text(' (${bengkel['reviews']})', style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                          const SizedBox(width: 12),
                          Icon(Icons.location_on, color: AppTheme.textGrey, size: 12),
                          Text(bengkel['distance'], style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                          const Spacer(),
                          Text(bengkel['priceRange'], style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (bengkel['promo'] != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_offer, color: AppTheme.successGreen, size: 12),
                    const SizedBox(width: 4),
                    Text(bengkel['promo'], style: const TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 8),
            Wrap(
              spacing: 6, runSpacing: 4,
              children: (bengkel['services'] as List<String>).map((s) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.06), borderRadius: BorderRadius.circular(6)),
                  child: Text(s, style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showBengkelDetail(Map<String, dynamic> bengkel) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BengkelDetailScreen(bengkel: bengkel)));
  }
}

class _FullMapScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bengkelList;
  const _FullMapScreen({required this.bengkelList});

  static const List<LatLng> _bengkelCoords = [
    LatLng(-6.9537, 107.6566), // AHASS Hero Motor
    LatLng(-6.9390, 107.6015), // Yamaha Bahana
    LatLng(-6.9218, 107.6275), // GP Motor
    LatLng(-6.9471, 107.6378), // AHASS Ria Motor
    LatLng(-6.9555, 107.6620), // Yamaha Arista
    LatLng(-6.9105, 107.6045), // TOP 1 Lombok Motor
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Bengkel'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-6.9175, 107.6191),
          initialZoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.otocare.astrapay',
          ),
          MarkerLayer(
            markers: [
              // User location
              Marker(
                point: LatLng(-6.9175, 107.6191),
                width: 24, height: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.3), blurRadius: 12)],
                  ),
                ),
              ),
              // Bengkel markers
              ...List.generate(bengkelList.length.clamp(0, _bengkelCoords.length), (i) {
                return Marker(
                  point: _bengkelCoords[i],
                  width: 120, height: 50,
                  child: Column(
                    children: [
                      Icon(Icons.location_on, color: Colors.red.shade700, size: 28),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
                        child: Text(bengkelList[i]['name'], style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class BengkelDetailScreen extends StatefulWidget {
  final Map<String, dynamic> bengkel;
  const BengkelDetailScreen({super.key, required this.bengkel});

  @override
  State<BengkelDetailScreen> createState() => _BengkelDetailScreenState();
}

class _BengkelDetailScreenState extends State<BengkelDetailScreen> {
  void _openWhatsApp(String phone, String bengkelName) async {
    final message = Uri.encodeComponent('Halo $bengkelName, saya ingin booking service via OtoCare. Apakah tersedia slot hari ini?');
    final url = Uri.parse('https://wa.me/$phone?text=$message');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bengkel = widget.bengkel;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(bengkel),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (bengkel['promo'] != null) _buildPromoCard(bengkel['promo']),
                    const SizedBox(height: 16),
                    _buildInfoSection(bengkel),
                    const SizedBox(height: 20),
                    _buildServicesOverview(bengkel),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            _buildBookingCTA(bengkel),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> bengkel) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 20),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
              Expanded(child: Text(bengkel['name'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
              GestureDetector(
                onTap: () => _openWhatsApp(bengkel['whatsapp'] ?? '6281234567890', bengkel['name']),
                child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.favorite_border, color: Colors.white),
              const SizedBox(width: 12),
              const Icon(Icons.share, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.build, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bengkel['address'], style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text('${bengkel['rating']} (${bengkel['reviews']} ulasan)', style: const TextStyle(color: Colors.white, fontSize: 12)),
                          const SizedBox(width: 12),
                          Text(bengkel['distance'], style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard(String promo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.successGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.successGreen.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: AppTheme.successGreen, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(promo, style: const TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.w600, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildInfoSection(Map<String, dynamic> bengkel) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
      child: Column(
        children: [
          _infoRow(Icons.access_time, 'Jam Operasional', '08:00 - 17:00 (Sen - Sab)'),
          const Divider(height: 16),
          _infoRow(Icons.phone, 'Telepon', '0812-3456-7890'),
          const Divider(height: 16),
          _infoRow(Icons.payments, 'Pembayaran', 'QRIS AstraPay, Cash'),
          const Divider(height: 16),
          _infoRow(Icons.attach_money, 'Harga', bengkel['priceRange']),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesOverview(Map<String, dynamic> bengkel) {
    final services = bengkel['services'] as List<String>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Layanan Tersedia', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: services.map((s) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, color: AppTheme.primaryBlue, size: 14),
                const SizedBox(width: 6),
                Text(s, style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
              ],
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildBookingCTA(Map<String, dynamic> bengkel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => _BookingWizardScreen(bengkel: bengkel)),
          ),
          icon: const Icon(Icons.calendar_today, size: 18),
          label: const Text('Buat Appointment', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// BOOKING WIZARD (Step-by-step like iColour)
// ==========================================
class _BookingWizardScreen extends StatefulWidget {
  final Map<String, dynamic> bengkel;
  const _BookingWizardScreen({required this.bengkel});

  @override
  State<_BookingWizardScreen> createState() => _BookingWizardScreenState();
}

class _BookingWizardScreenState extends State<_BookingWizardScreen> {
  int _currentStep = 0;
  String? _selectedService;
  DateTime? _selectedDate;
  String? _selectedTime;
  String _notes = '';

  final List<String> _timeSlots = ['08:00', '09:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00'];
  final List<String> _stepTitles = ['Layanan', 'Tanggal', 'Waktu', 'Konfirmasi'];

  bool get _canNext {
    switch (_currentStep) {
      case 0: return _selectedService != null;
      case 1: return _selectedDate != null;
      case 2: return _selectedTime != null;
      default: return true;
    }
  }

  void _next() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      _submitBooking();
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppTheme.textDark),
          onPressed: _back,
        ),
        title: Text('Buat Appointment', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(child: _buildStepContent()),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: List.generate(4, (i) {
              final isActive = i <= _currentStep;
              final isDone = i < _currentStep;
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                        color: isDone ? AppTheme.successGreen : (isActive ? AppTheme.primaryBlue : Colors.grey.shade200),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isDone
                          ? const Icon(Icons.check, color: Colors.white, size: 14)
                          : Text('${i + 1}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isActive ? Colors.white : AppTheme.textGrey)),
                      ),
                    ),
                    if (i < 3) Expanded(
                      child: Container(
                        height: 2,
                        color: i < _currentStep ? AppTheme.successGreen : Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            children: _stepTitles.asMap().entries.map((e) {
              final isActive = e.key <= _currentStep;
              return Expanded(
                child: Text(
                  e.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0: return _stepService();
      case 1: return _stepDate();
      case 2: return _stepTime();
      case 3: return _stepConfirm();
      default: return const SizedBox.shrink();
    }
  }

  // Step 1: Pilih Layanan
  Widget _stepService() {
    final services = widget.bengkel['services'] as List<String>;
    final serviceIcons = {
      'Ganti Oli': Icons.water_drop,
      'Tune Up': Icons.settings,
      'Injeksi': Icons.speed,
      'CVT': Icons.settings_applications,
      'V-Belt': Icons.link,
      'Bore Up': Icons.rocket_launch,
      'Overhaul': Icons.engineering,
      'Kopling': Icons.disc_full,
      'Rem': Icons.do_not_disturb_on,
      'Rantai': Icons.link,
      'Servis Berkala': Icons.event_repeat,
      'Elektrikal': Icons.electrical_services,
      'Oli': Icons.water_drop,
    };
    final servicePrices = {
      'Ganti Oli': 'Rp 75.000 - 120.000',
      'Tune Up': 'Rp 100.000 - 200.000',
      'Injeksi': 'Rp 50.000 - 150.000',
      'CVT': 'Rp 150.000 - 350.000',
      'V-Belt': 'Rp 200.000 - 400.000',
      'Bore Up': 'Rp 500.000 - 1.500.000',
      'Overhaul': 'Rp 300.000 - 800.000',
      'Kopling': 'Rp 100.000 - 250.000',
      'Rem': 'Rp 80.000 - 180.000',
      'Rantai': 'Rp 100.000 - 200.000',
      'Servis Berkala': 'Rp 100.000 - 250.000',
      'Elektrikal': 'Rp 50.000 - 300.000',
      'Oli': 'Rp 75.000 - 120.000',
    };

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Pilih layanan yang kamu butuhkan', style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
        const SizedBox(height: 16),
        ...services.map((s) {
          final isSelected = _selectedService == s;
          final icon = serviceIcons.entries.firstWhere((e) => s.contains(e.key), orElse: () => MapEntry('', Icons.build)).value;
          final price = servicePrices.entries.firstWhere((e) => s.contains(e.key), orElse: () => MapEntry('', 'Rp 50.000 - 200.000')).value;
          return GestureDetector(
            onTap: () => setState(() => _selectedService = s),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryBlue.withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isSelected ? AppTheme.primaryBlue : Colors.grey.shade200, width: isSelected ? 2 : 1),
                boxShadow: isSelected ? [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.1), blurRadius: 8)] : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryBlue.withOpacity(0.15) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(icon, color: isSelected ? AppTheme.primaryBlue : AppTheme.textGrey, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isSelected ? AppTheme.primaryBlue : AppTheme.textDark)),
                        const SizedBox(height: 4),
                        Text(price, style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: 24, height: 24,
                      decoration: const BoxDecoration(color: AppTheme.primaryBlue, shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: Colors.white, size: 14),
                    )
                  else
                    Container(
                      width: 24, height: 24,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300, width: 2)),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // Step 2: Pilih Tanggal
  Widget _stepDate() {
    final now = DateTime.now();
    final dates = List.generate(14, (i) => now.add(Duration(days: i + 1)));
    final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Pilih tanggal appointment', style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${months[now.month - 1]} ${now.year}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemCount: dates.length,
                itemBuilder: (ctx, i) {
                  final d = dates[i];
                  final isSelected = _selectedDate != null && _selectedDate!.day == d.day && _selectedDate!.month == d.month;
                  final isSunday = d.weekday == 7;
                  return GestureDetector(
                    onTap: isSunday ? null : () => setState(() => _selectedDate = d),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryBlue : (isSunday ? Colors.grey.shade100 : Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(days[d.weekday - 1], style: TextStyle(fontSize: 9, color: isSelected ? Colors.white70 : (isSunday ? Colors.grey.shade400 : AppTheme.textGrey))),
                          const SizedBox(height: 2),
                          Text('${d.day}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : (isSunday ? Colors.grey.shade400 : AppTheme.textDark))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        if (_selectedDate != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.05), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Icon(Icons.event, color: AppTheme.primaryBlue, size: 18),
                const SizedBox(width: 8),
                Text(
                  '${days[_selectedDate!.weekday - 1]}, ${_selectedDate!.day} ${months[_selectedDate!.month - 1]} ${_selectedDate!.year}',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.primaryBlue),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // Step 3: Pilih Waktu
  Widget _stepTime() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Pilih waktu yang tersedia', style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
        const SizedBox(height: 6),
        Text('Durasi estimasi: 30 - 60 menit', style: TextStyle(fontSize: 12, color: AppTheme.textGrey.withOpacity(0.7))),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pagi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10, runSpacing: 10,
                children: _timeSlots.sublist(0, 4).map((t) => _timeChip(t)).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Siang', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10, runSpacing: 10,
                children: _timeSlots.sublist(4).map((t) => _timeChip(t)).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('Catatan (opsional)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 8),
        TextField(
          onChanged: (v) => _notes = v,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Keluhan atau permintaan khusus...',
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryBlue)),
          ),
        ),
      ],
    );
  }

  Widget _timeChip(String time) {
    final isSelected = _selectedTime == time;
    final isUnavailable = time == '11:00'; // simulate one slot taken
    return GestureDetector(
      onTap: isUnavailable ? null : () => setState(() => _selectedTime = time),
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isUnavailable ? Colors.grey.shade100 : (isSelected ? AppTheme.primaryBlue : Colors.white),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isUnavailable ? Colors.grey.shade200 : (isSelected ? AppTheme.primaryBlue : Colors.grey.shade200),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(time, style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600,
              color: isUnavailable ? Colors.grey.shade400 : (isSelected ? Colors.white : AppTheme.textDark),
            )),
            if (isUnavailable) Text('Penuh', style: TextStyle(fontSize: 9, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }

  // Step 4: Konfirmasi
  Widget _stepConfirm() {
    final bengkel = widget.bengkel;
    final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    final dateStr = _selectedDate != null
      ? '${days[_selectedDate!.weekday - 1]}, ${_selectedDate!.day} ${months[_selectedDate!.month - 1]} ${_selectedDate!.year}'
      : '-';

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Periksa detail appointment kamu', style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
          child: Column(
            children: [
              _confirmRow(Icons.store, 'Bengkel', bengkel['name']),
              _divider(),
              _confirmRow(Icons.build, 'Layanan', _selectedService ?? '-'),
              _divider(),
              _confirmRow(Icons.calendar_today, 'Tanggal', dateStr),
              _divider(),
              _confirmRow(Icons.access_time, 'Waktu', _selectedTime ?? '-'),
              if (_notes.isNotEmpty) ...[
                _divider(),
                _confirmRow(Icons.note, 'Catatan', _notes),
              ],
              _divider(),
              _confirmRow(Icons.payments, 'Pembayaran', 'QRIS AstraPay'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: AppTheme.primaryBlue, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Estimasi Biaya', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    Text('Rp 75.000 - Rp 150.000', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.primaryBlue)),
                    const SizedBox(height: 2),
                    Text('*Harga final ditentukan setelah inspeksi', style: TextStyle(fontSize: 10, color: AppTheme.textGrey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirmRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 18),
          const SizedBox(width: 12),
          SizedBox(width: 70, child: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textDark))),
        ],
      ),
    );
  }

  Widget _divider() => Divider(height: 1, color: Colors.grey.shade100);

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: _back,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: const Text('Kembali', style: TextStyle(color: AppTheme.textDark)),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _canNext ? _next : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _canNext ? AppTheme.primaryBlue : Colors.grey.shade300,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                _currentStep == 3 ? 'Konfirmasi Booking' : 'Lanjut',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitBooking() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 52),
            ),
            const SizedBox(height: 16),
            const Text('Appointment Berhasil! 🎉', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 8),
            Text(
              '${widget.bengkel['name']}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark),
            ),
            const SizedBox(height: 4),
            Text(
              '$_selectedService · ${_selectedDate?.day}/${_selectedDate?.month} · $_selectedTime',
              style: const TextStyle(fontSize: 13, color: AppTheme.textGrey),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Bengkel akan mengonfirmasi appointment Anda. Notifikasi akan dikirim saat dikonfirmasi.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppTheme.textGrey, height: 1.4),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () { Navigator.pop(ctx); Navigator.pop(context); Navigator.pop(context); },
                icon: const Icon(Icons.qr_code, size: 18),
                label: const Text('Bayar via AstraPay'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () { Navigator.pop(ctx); Navigator.pop(context); Navigator.pop(context); },
              child: const Text('Kembali ke Beranda', style: TextStyle(color: AppTheme.textGrey)),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
