import 'package:flutter/material.dart';
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
      'name': 'Bengkel Jaya Motor',
      'address': 'Jl. Raya Margahayu No. 15, Bandung',
      'rating': 4.8,
      'reviews': 234,
      'distance': '1.2 km',
      'isOpen': true,
      'services': ['Ganti Oli', 'Tune Up', 'Servis Berkala', 'Rem'],
      'promo': 'Diskon 15% Ganti Oli',
      'image': 'bengkel1',
      'priceRange': 'Rp 50rb - 500rb',
    },
    {
      'name': 'Mitra Motor Sejahtera',
      'address': 'Jl. Soekarno Hatta No. 120, Bandung',
      'rating': 4.6,
      'reviews': 189,
      'distance': '1.8 km',
      'isOpen': true,
      'services': ['All Brand', 'Overhaul', 'Elektrikal', 'Body'],
      'promo': 'Cashback Rp50rb AstraPay',
      'image': 'bengkel2',
      'priceRange': 'Rp 75rb - 1.5jt',
    },
    {
      'name': 'Bengkel Pak Budi',
      'address': 'Jl. Buah Batu No. 88, Bandung',
      'rating': 4.5,
      'reviews': 156,
      'distance': '2.1 km',
      'isOpen': true,
      'services': ['Honda Specialist', 'Ganti Oli', 'Rem', 'Rantai'],
      'promo': null,
      'image': 'bengkel3',
      'priceRange': 'Rp 30rb - 300rb',
    },
    {
      'name': 'Bengkel Abadi Motor',
      'address': 'Jl. Cibaduyut No. 45, Bandung',
      'rating': 4.7,
      'reviews': 312,
      'distance': '3.0 km',
      'isOpen': false,
      'services': ['Yamaha Specialist', 'Injeksi', 'CVT', 'Oli'],
      'promo': 'Free Check-up 10 Titik',
      'image': 'bengkel4',
      'priceRange': 'Rp 40rb - 600rb',
    },
    {
      'name': 'Speed Motor Workshop',
      'address': 'Jl. Pasteur No. 200, Bandung',
      'rating': 4.4,
      'reviews': 98,
      'distance': '3.5 km',
      'isOpen': true,
      'services': ['All Brand', 'Bore Up', 'Tune Up', 'Kopling'],
      'promo': 'Gratis Nitrogen',
      'image': 'bengkel5',
      'priceRange': 'Rp 50rb - 2jt',
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
            color: const Color(0xFFE8F4E8),
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
          ),
          child: Stack(
            children: [
              // Simulated map background with grid lines
              CustomPaint(painter: _MapGridPainter(), child: Container()),
              // Pin markers
              Positioned(top: 25, left: 60, child: _mapPin(Colors.red)),
              Positioned(top: 45, left: 140, child: _mapPin(AppTheme.primaryBlue)),
              Positioned(top: 35, right: 80, child: _mapPin(AppTheme.successGreen)),
              Positioned(bottom: 30, left: 100, child: _mapPin(AppTheme.warningOrange)),
              Positioned(bottom: 25, right: 50, child: _mapPin(Colors.purple)),
              // Center user location
              Positioned(
                top: 50, left: 0, right: 0,
                child: Center(
                  child: Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.3), blurRadius: 8)],
                    ),
                  ),
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
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.build, color: AppTheme.primaryBlue, size: 24),
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

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.15)
      ..strokeWidth = 0.5;
    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
    // Roads
    final roadPaint = Paint()..color = Colors.white.withOpacity(0.7)..strokeWidth = 3;
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.5), roadPaint);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.4, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.65, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FullMapScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bengkelList;
  const _FullMapScreen({required this.bengkelList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Bengkel'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE8F4E8),
            child: CustomPaint(painter: _MapGridPainter(), child: Container()),
          ),
          // Pins
          ...List.generate(bengkelList.length, (i) {
            final top = 80.0 + (i * 90);
            final left = 40.0 + (i * 50) % 200;
            return Positioned(
              top: top, left: left,
              child: Column(
                children: [
                  const Icon(Icons.location_on, color: Colors.red, size: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                    child: Text(bengkelList[i]['name'], style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            );
          }),
          // User location
          Center(
            child: Container(
              width: 20, height: 20,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.3), blurRadius: 12)],
              ),
            ),
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
