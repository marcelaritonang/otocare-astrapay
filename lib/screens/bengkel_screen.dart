import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BengkelScreen extends StatefulWidget {
  const BengkelScreen({super.key});

  @override
  State<BengkelScreen> createState() => _BengkelScreenState();
}

class _BengkelScreenState extends State<BengkelScreen> {
  int _selectedCategory = 0;
  final List<Map<String, dynamic>> _categories = [
    {'label': 'Semua', 'icon': Icons.apps},
    {'label': 'Motor', 'icon': Icons.two_wheeler},
    {'label': 'Mobil', 'icon': Icons.directions_car},
    {'label': 'Promo', 'icon': Icons.local_offer},
  ];

  final List<Map<String, dynamic>> _bengkelList = [
    {
      'name': 'AHASS',
      'description': 'Honda Authorized Service Station',
      'type': 'Motor',
      'rating': 4.8,
      'distance': '1.2 km',
      'promo': 'Diskon 20% Servis Berkala',
      'services': ['Servis Berkala', 'Ganti Oli', 'Tune Up', 'Overhaul'],
      'color': Color(0xFFE31937),
    },
    {
      'name': 'Auto 2000',
      'description': 'Toyota Authorized Dealer & Service',
      'type': 'Mobil',
      'rating': 4.7,
      'distance': '2.5 km',
      'promo': 'Cashback Rp100rb via AstraPay',
      'services': ['Servis Berkala', 'Body & Paint', 'Tune Up', 'AC Service'],
      'color': Color(0xFF1B4D8E),
    },
    {
      'name': 'Astra Daihatsu',
      'description': 'Daihatsu Authorized Service',
      'type': 'Mobil',
      'rating': 4.6,
      'distance': '3.1 km',
      'promo': 'Free Check Up 20 Titik',
      'services': ['Servis Berkala', 'Ganti Oli', 'Rem & Suspensi', 'AC'],
      'color': Color(0xFFD4001A),
    },
    {
      'name': 'Astra Isuzu',
      'description': 'Isuzu Authorized Service Center',
      'type': 'Mobil',
      'rating': 4.5,
      'distance': '4.8 km',
      'promo': 'Gratis Oli untuk Servis Pertama',
      'services': ['Servis Berkala', 'Ganti Oli', 'Engine Overhaul', 'Elektrikal'],
      'color': Color(0xFF003087),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildSearchBar(),
            _buildCategoryFilter(),
            Expanded(child: _buildBengkelList()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              'Bengkel & Servis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.history, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'Riwayat',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppTheme.textGrey, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari bengkel atau layanan...',
                  hintStyle: TextStyle(
                    color: AppTheme.textLight,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.tune, color: AppTheme.primaryBlue, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = _selectedCategory == index;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => setState(() => _selectedCategory = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryBlue : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryBlue
                          : AppTheme.textLight.withOpacity(0.3),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppTheme.primaryBlue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _categories[index]['icon'],
                        size: 16,
                        color: isSelected ? Colors.white : AppTheme.textGrey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _categories[index]['label'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : AppTheme.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBengkelList() {
    final filtered = _selectedCategory == 0
        ? _bengkelList
        : _selectedCategory == 1
            ? _bengkelList.where((b) => b['type'] == 'Motor').toList()
            : _selectedCategory == 2
                ? _bengkelList.where((b) => b['type'] == 'Mobil').toList()
                : _bengkelList;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filtered.length + 1, // +1 for header promo
      itemBuilder: (context, index) {
        if (index == 0) return _buildTopPromo();
        final bengkel = filtered[index - 1];
        return _buildBengkelCard(bengkel);
      },
    );
  }

  Widget _buildTopPromo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A6FE8), Color(0xFF4FC3F7)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Servis Hemat! 🔧',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bayar servis kendaraan pakai AstraPay, selalu ada cashback!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Lihat Promo',
                    style: TextStyle(
                      color: AppTheme.primaryBlue,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.build_circle,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBengkelCard(Map<String, dynamic> bengkel) {
    return GestureDetector(
      onTap: () => _showBengkelDetail(bengkel),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (bengkel['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    bengkel['type'] == 'Motor'
                        ? Icons.two_wheeler
                        : Icons.directions_car,
                    color: bengkel['color'],
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bengkel['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      Text(
                        bengkel['description'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 2),
                        Text(
                          '${bengkel['rating']}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: AppTheme.textGrey, size: 12),
                        Text(
                          bengkel['distance'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Promo tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_offer,
                      color: AppTheme.successGreen, size: 14),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      bengkel['promo'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.successGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Services
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: (bengkel['services'] as List<String>).map((s) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    s,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showBengkelDetail(Map<String, dynamic> bengkel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BengkelDetailScreen(bengkel: bengkel),
      ),
    );
  }
}

// Detail Screen
class BengkelDetailScreen extends StatelessWidget {
  final Map<String, dynamic> bengkel;

  const BengkelDetailScreen({super.key, required this.bengkel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 20),
              decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          bengkel['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(Icons.favorite_border, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Bengkel info card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            bengkel['type'] == 'Motor'
                                ? Icons.two_wheeler
                                : Icons.directions_car,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bengkel['description'],
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${bengkel['rating']} · ${bengkel['distance']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Promo
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.successGreen.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.local_offer,
                              color: AppTheme.successGreen, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              bengkel['promo'],
                              style: TextStyle(
                                color: AppTheme.successGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Pilih Layanan
                    const Text(
                      'Pilih Layanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...(bengkel['services'] as List<String>).map((service) {
                      return _serviceOption(service);
                    }),
                    const SizedBox(height: 20),
                    // Booking Section
                    const Text(
                      'Jadwal Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDatePicker(),
                    const SizedBox(height: 12),
                    _buildTimePicker(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Bottom CTA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showBookingConfirmation(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Booking Sekarang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceOption(String service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: Icon(
              _getServiceIcon(service),
              color: AppTheme.primaryBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              service,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textDark,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: AppTheme.textGrey),
        ],
      ),
    );
  }

  IconData _getServiceIcon(String service) {
    if (service.contains('Oli')) return Icons.water_drop;
    if (service.contains('Tune')) return Icons.settings;
    if (service.contains('Body')) return Icons.format_paint;
    if (service.contains('AC')) return Icons.ac_unit;
    if (service.contains('Rem')) return Icons.disc_full;
    if (service.contains('Engine') || service.contains('Overhaul')) {
      return Icons.engineering;
    }
    if (service.contains('Elektrikal')) return Icons.electric_bolt;
    return Icons.build;
  }

  Widget _buildDatePicker() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: AppTheme.primaryBlue, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Pilih Tanggal',
              style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
            ),
          ),
          Icon(Icons.chevron_right, color: AppTheme.textGrey),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: AppTheme.primaryBlue, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Pilih Waktu',
              style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
            ),
          ),
          Icon(Icons.chevron_right, color: AppTheme.textGrey),
        ],
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
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
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppTheme.successGreen,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Booking Berhasil! 🎉',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Booking servis di ${bengkel['name']} berhasil.\nKami akan mengirim reminder H-1.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textGrey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                child: const Text('Kembali ke Beranda'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
