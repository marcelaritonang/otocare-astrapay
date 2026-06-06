import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
      'reviews': 256,
      'distance': '2.1 km',
      'isOpen': true,
      'services': ['All Brand', 'Bore Up', 'Overhaul', 'Kopling'],
      'promo': null,
      'image': 'https://images.unsplash.com/photo-1650569663338-f6921d483868?w=400&fit=crop',
      'priceRange': 'Rp 40rb - 600rb',
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
  String? _selectedService;
  DateTime? _selectedDate;
  String? _selectedTime;

  final List<String> _timeSlots = ['08:00', '09:00', '10:00', '11:00', '13:00', '14:00', '15:00', '16:00'];

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
                    _buildServiceSelection(bengkel),
                    const SizedBox(height: 20),
                    _buildDateSelection(),
                    const SizedBox(height: 16),
                    _buildTimeSelection(),
                    const SizedBox(height: 16),
                    _buildCostEstimate(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            _buildBookingButton(),
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

  Widget _buildServiceSelection(Map<String, dynamic> bengkel) {
    final services = bengkel['services'] as List<String>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pilih Layanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 10),
        ...services.map((s) => GestureDetector(
          onTap: () => setState(() => _selectedService = s),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _selectedService == s ? AppTheme.primaryBlue.withOpacity(0.05) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _selectedService == s ? AppTheme.primaryBlue : Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.build, color: AppTheme.primaryBlue, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(s, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
                if (_selectedService == s) const Icon(Icons.check_circle, color: AppTheme.primaryBlue, size: 20),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildDateSelection() {
    final now = DateTime.now();
    final dates = List.generate(7, (i) => now.add(Duration(days: i + 1)));
    final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pilih Tanggal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dates.map((d) {
              final isSelected = _selectedDate == d;
              return GestureDetector(
                onTap: () => setState(() => _selectedDate = d),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryBlue : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: isSelected ? AppTheme.primaryBlue : Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(days[d.weekday - 1], style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : AppTheme.textGrey)),
                      const SizedBox(height: 4),
                      Text('${d.day}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppTheme.textDark)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pilih Waktu', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: _timeSlots.map((t) {
            final isSelected = _selectedTime == t;
            return GestureDetector(
              onTap: () => setState(() => _selectedTime = t),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isSelected ? AppTheme.primaryBlue : Colors.grey.shade200),
                ),
                child: Text(t, style: TextStyle(fontSize: 13, color: isSelected ? Colors.white : AppTheme.textDark, fontWeight: FontWeight.w500)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCostEstimate() {
    if (_selectedService == null) return const SizedBox.shrink();
    return Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingButton() {
    final canBook = _selectedService != null && _selectedDate != null && _selectedTime != null;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canBook ? () => _confirmBooking() : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: canBook ? AppTheme.primaryBlue : Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            canBook ? 'Booking Sekarang' : 'Pilih layanan, tanggal & waktu',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: canBook ? Colors.white : AppTheme.textGrey),
          ),
        ),
      ),
    );
  }

  void _confirmBooking() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 48),
            ),
            const SizedBox(height: 16),
            const Text('Booking Berhasil! 🎉', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 8),
            Text(
              '${widget.bengkel['name']}\n$_selectedService · ${_selectedDate?.day}/${_selectedDate?.month} · $_selectedTime',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: AppTheme.textGrey),
            ),
            const SizedBox(height: 8),
            const Text('Bengkel akan konfirmasi & kirim estimasi biaya.', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () { Navigator.pop(ctx); Navigator.pop(context); },
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () { Navigator.pop(ctx); Navigator.pop(context); },
                    icon: const Icon(Icons.qr_code, size: 16),
                    label: const Text('Bayar via AstraPay'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
