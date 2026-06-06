import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class KatalogTab extends StatefulWidget {
  const KatalogTab({super.key});

  @override
  State<KatalogTab> createState() => _KatalogTabState();
}

class _KatalogTabState extends State<KatalogTab> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  final List<String> _categories = [
    'Semua',
    'Rutin',
    'Perbaikan',
    'Modifikasi',
    'Darurat',
  ];

  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Ganti Oli',
      'category': 'Rutin',
      'minPrice': 50000,
      'maxPrice': 85000,
      'duration': '30 menit',
      'icon': Icons.oil_barrel,
      'popular': true,
      'promo': false,
      'active': true,
      'customerCount': 187,
      'description': 'Penggantian oli mesin motor matic & manual',
      'parts': ['Oli Yamalube', 'Oli Federal', 'Filter Oli'],
    },
    {
      'name': 'Tune Up',
      'category': 'Rutin',
      'minPrice': 80000,
      'maxPrice': 150000,
      'duration': '1 jam',
      'icon': Icons.settings,
      'popular': true,
      'promo': true,
      'active': true,
      'customerCount': 125,
      'description': 'Servis lengkap: busi, filter, karburator, valve',
      'parts': ['Busi NGK', 'Filter Udara', 'Karburator Kit'],
    },
    {
      'name': 'Ganti Kampas Rem',
      'category': 'Perbaikan',
      'minPrice': 80000,
      'maxPrice': 150000,
      'duration': '30 menit',
      'icon': Icons.disc_full,
      'popular': false,
      'promo': false,
      'active': true,
      'customerCount': 98,
      'description': 'Penggantian kampas rem depan/belakang',
      'parts': ['Kampas Rem Depan', 'Kampas Rem Belakang'],
    },
    {
      'name': 'Ganti V-Belt',
      'category': 'Perbaikan',
      'minPrice': 150000,
      'maxPrice': 280000,
      'duration': '1 jam',
      'icon': Icons.settings_suggest,
      'popular': false,
      'promo': true,
      'active': true,
      'customerCount': 76,
      'description': 'Penggantian V-Belt motor matic',
      'parts': ['V-Belt', 'Roller', 'Per CVT'],
    },
    {
      'name': 'Servis CVT',
      'category': 'Perbaikan',
      'minPrice': 200000,
      'maxPrice': 400000,
      'duration': '2 jam',
      'icon': Icons.precision_manufacturing,
      'popular': true,
      'promo': false,
      'active': true,
      'customerCount': 63,
      'description': 'Bongkar, bersih, ganti komponen CVT lengkap',
      'parts': ['V-Belt', 'Roller', 'Per CVT', 'Kampas Ganda', 'Bearing'],
    },
    {
      'name': 'Ganti Ban',
      'category': 'Perbaikan',
      'minPrice': 150000,
      'maxPrice': 350000,
      'duration': '30 menit',
      'icon': Icons.tire_repair,
      'popular': false,
      'promo': false,
      'active': true,
      'customerCount': 112,
      'description': 'Penggantian ban tubeless/tube type depan & belakang',
      'parts': ['Ban IRC', 'Ban FDR', 'Ban Michelin', 'Pentil'],
    },
    {
      'name': 'Spooring & Balancing',
      'category': 'Modifikasi',
      'minPrice': 75000,
      'maxPrice': 150000,
      'duration': '1 jam',
      'icon': Icons.track_changes,
      'popular': false,
      'promo': false,
      'active': true,
      'customerCount': 34,
      'description': 'Penyetelan kelurusan roda dan balancing',
      'parts': ['Timah Balancing', 'Bearing Roda'],
    },
    {
      'name': 'Overhaul Mesin',
      'category': 'Perbaikan',
      'minPrice': 800000,
      'maxPrice': 2500000,
      'duration': '3 jam',
      'icon': Icons.build_circle,
      'popular': false,
      'promo': false,
      'active': true,
      'customerCount': 18,
      'description': 'Bongkar mesin total, ganti piston, ring, boring',
      'parts': ['Piston Kit', 'Ring Piston', 'Gasket Set', 'Bearing Kruk As', 'Oli Mesin'],
    },
    {
      'name': 'Service Injeksi',
      'category': 'Rutin',
      'minPrice': 100000,
      'maxPrice': 200000,
      'duration': '1 jam',
      'icon': Icons.water_drop,
      'popular': true,
      'promo': false,
      'active': true,
      'customerCount': 145,
      'description': 'Pembersihan & kalibrasi injektor motor FI',
      'parts': ['Cairan Injector Cleaner', 'Filter Bensin', 'O-Ring Injektor'],
    },
    {
      'name': 'Ganti Aki',
      'category': 'Darurat',
      'minPrice': 150000,
      'maxPrice': 350000,
      'duration': '30 menit',
      'icon': Icons.battery_charging_full,
      'popular': false,
      'promo': true,
      'active': true,
      'customerCount': 89,
      'description': 'Penggantian aki motor MF (Maintenance Free)',
      'parts': ['Aki GS Astra', 'Aki Yuasa', 'Terminal Aki'],
    },
    {
      'name': 'Tambal Ban Darurat',
      'category': 'Darurat',
      'minPrice': 15000,
      'maxPrice': 35000,
      'duration': '30 menit',
      'icon': Icons.emergency,
      'popular': false,
      'promo': false,
      'active': true,
      'customerCount': 203,
      'description': 'Tambal ban tubeless cepat tanpa bongkar',
      'parts': ['Cacing Tambal', 'Lem Ban', 'Angin Nitrogen'],
    },
    {
      'name': 'Pasang Aksesori',
      'category': 'Modifikasi',
      'minPrice': 50000,
      'maxPrice': 500000,
      'duration': '1 jam',
      'icon': Icons.auto_awesome,
      'popular': false,
      'promo': false,
      'active': false,
      'customerCount': 42,
      'description': 'Pemasangan windshield, crashbar, bracket, dll',
      'parts': ['Bracket Universal', 'Baut Stainless', 'Kabel Ties'],
    },
  ];

  List<Map<String, dynamic>> get _filteredServices {
    return _services.where((service) {
      final matchCategory = _selectedCategory == 'Semua' ||
          service['category'] == _selectedCategory;
      final matchSearch = _searchQuery.isEmpty ||
          (service['name'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

  int get _activeCount =>
      _services.where((s) => s['active'] == true).length;

  int get _promoCount =>
      _services.where((s) => s['promo'] == true).length;

  String get _avgRevenueEstimate {
    final activeServices = _services.where((s) => s['active'] == true);
    if (activeServices.isEmpty) return 'Rp 0';
    final totalAvg = activeServices.fold<int>(0, (sum, s) {
      return sum + (((s['minPrice'] as int) + (s['maxPrice'] as int)) ~/ 2);
    });
    final avg = totalAvg ~/ activeServices.length;
    if (avg >= 1000000) {
      return 'Rp ${(avg / 1000000).toStringAsFixed(1)}jt';
    }
    return 'Rp ${(avg / 1000).toStringAsFixed(0)}rb';
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Rutin':
        return AppTheme.primaryBlue;
      case 'Perbaikan':
        return AppTheme.warningOrange;
      case 'Modifikasi':
        return const Color(0xFF8B5CF6);
      case 'Darurat':
        return const Color(0xFFEF4444);
      default:
        return AppTheme.textGrey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Rutin':
        return Icons.repeat;
      case 'Perbaikan':
        return Icons.build;
      case 'Modifikasi':
        return Icons.auto_awesome;
      case 'Darurat':
        return Icons.warning_amber_rounded;
      default:
        return Icons.category;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          _buildStatsBar(),
          _buildCategoryTabs(),
          Expanded(child: _buildServiceGrid(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Katalog Layanan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Row(
                children: [
                  _buildHeaderAction(
                    icon: Icons.filter_list_rounded,
                    onTap: () => _showFilterSheet(context),
                  ),
                  const SizedBox(width: 8),
                  _buildHeaderAction(
                    icon: Icons.add_rounded,
                    onTap: () => _showAddService(context),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Cari layanan...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
                prefixIcon: Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.7), size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.7), size: 18),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAction({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          _buildStatItem(
            '$_activeCount Layanan Aktif',
            Icons.check_circle_outline_rounded,
            AppTheme.successGreen,
          ),
          Container(
            width: 1,
            height: 16,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey.shade300,
          ),
          _buildStatItem(
            '$_promoCount Promo',
            Icons.local_offer_outlined,
            AppTheme.warningOrange,
          ),
          Container(
            width: 1,
            height: 16,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey.shade300,
          ),
          _buildStatItem(
            '$_avgRevenueEstimate avg',
            Icons.trending_up_rounded,
            AppTheme.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, IconData icon, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark.withOpacity(0.8),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryBlue : Colors.grey.shade300,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryBlue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (category != 'Semua') ...[
                      Icon(
                        _getCategoryIcon(category),
                        size: 14,
                        color: isSelected ? Colors.white : _getCategoryColor(category),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    final filtered = _filteredServices;

    if (filtered.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return _buildServiceCard(context, filtered[index], _services.indexOf(filtered[index]));
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppTheme.primaryBlue.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada layanan ditemukan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Coba kata kunci lain atau ubah filter kategori'
                : 'Belum ada layanan di kategori "$_selectedCategory"',
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textGrey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _selectedCategory = 'Semua';
                _searchController.clear();
                _searchQuery = '';
              });
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Reset Filter'),
            style: TextButton.styleFrom(foregroundColor: AppTheme.primaryBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service, int index) {
    final categoryColor = _getCategoryColor(service['category']);
    final isActive = service['active'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Colors.grey.shade100 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isActive ? 0.05 : 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.6,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      service['icon'] as IconData,
                      color: categoryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Service details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                service['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ),
                            if (service['popular'] == true)
                              _buildBadge('Popular', AppTheme.warningOrange),
                            if (service['promo'] == true) ...[
                              const SizedBox(width: 4),
                              _buildBadge('Promo', AppTheme.successGreen),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Category badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: categoryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            service['category'],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: categoryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Price
                        Text(
                          'Rp ${_formatPrice(service['minPrice'])} - ${_formatPrice(service['maxPrice'])}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Duration & customer count
                        Row(
                          children: [
                            Icon(Icons.schedule_rounded, size: 13, color: AppTheme.textGrey.withOpacity(0.8)),
                            const SizedBox(width: 4),
                            Text(
                              service['duration'],
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textGrey.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Icon(Icons.people_outline_rounded, size: 13, color: AppTheme.textGrey.withOpacity(0.8)),
                            const SizedBox(width: 4),
                            Text(
                              '${service['customerCount']} pelanggan bulan ini',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textGrey.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Toggle active/inactive
                  Column(
                    children: [
                      Transform.scale(
                        scale: 0.75,
                        child: Switch(
                          value: isActive,
                          onChanged: (value) {
                            setState(() => _services[index]['active'] = value);
                          },
                          activeColor: AppTheme.successGreen,
                          inactiveThumbColor: Colors.grey.shade400,
                          inactiveTrackColor: Colors.grey.shade200,
                        ),
                      ),
                      Text(
                        isActive ? 'Aktif' : 'Nonaktif',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: isActive ? AppTheme.successGreen : AppTheme.textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Quick action bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickAction(Icons.edit_outlined, 'Edit', () {
                    _showEditService(context, service, index);
                  }),
                  _buildQuickAction(Icons.copy_outlined, 'Duplikat', () {
                    _duplicateService(index);
                  }),
                  _buildQuickAction(Icons.share_outlined, 'Share', () {
                    _shareService(context, service);
                  }),
                  _buildQuickAction(Icons.delete_outline_rounded, 'Hapus', () {
                    _showDeleteConfirmation(context, service, index);
                  }, color: const Color(0xFFEF4444)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap, {Color? color}) {
    final actionColor = color ?? AppTheme.textGrey;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: actionColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: actionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}jt';
    } else if (price >= 1000) {
      final thousands = price / 1000;
      if (thousands == thousands.roundToDouble()) {
        return '${thousands.toInt()}rb';
      }
      return '${thousands.toStringAsFixed(0)}rb';
    }
    return price.toString();
  }

  void _duplicateService(int index) {
    final original = Map<String, dynamic>.from(_services[index]);
    original['name'] = '${original['name']} (Copy)';
    original['popular'] = false;
    original['promo'] = false;
    original['customerCount'] = 0;
    setState(() {
      _services.insert(index + 1, original);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Layanan berhasil diduplikasi'),
        backgroundColor: AppTheme.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _shareService(BuildContext context, Map<String, dynamic> service) {
    final text =
        '${service['name']}\n'
        'Kategori: ${service['category']}\n'
        'Harga: Rp ${_formatPrice(service['minPrice'])} - ${_formatPrice(service['maxPrice'])}\n'
        'Durasi: ${service['duration']}';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link layanan "${service['name']}" disalin!'),
        backgroundColor: AppTheme.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Filter & Sortir',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Sortir berdasarkan:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('Terpopuler', true),
                _buildFilterChip('Harga Terendah', false),
                _buildFilterChip('Harga Tertinggi', false),
                _buildFilterChip('Terbaru', false),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Status:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('Semua', true),
                _buildFilterChip('Aktif', false),
                _buildFilterChip('Nonaktif', false),
                _buildFilterChip('Promo', false),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Terapkan Filter',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppTheme.primaryBlue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? AppTheme.primaryBlue : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : AppTheme.textDark,
        ),
      ),
    );
  }

  void _showEditService(BuildContext context, Map<String, dynamic> service, int index) {
    final nameController = TextEditingController(text: service['name']);
    final minPriceController = TextEditingController(text: service['minPrice'].toString());
    final maxPriceController = TextEditingController(text: service['maxPrice'].toString());
    final descController = TextEditingController(text: service['description'] ?? '');
    String selectedCategory = service['category'];
    String selectedDuration = service['duration'];
    bool isPopular = service['popular'] ?? false;
    bool isPromo = service['promo'] ?? false;
    List<String> parts = List<String>.from(service['parts'] ?? []);
    final partsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Layanan',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Scrollable form
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFormLabel('Nama Layanan'),
                      const SizedBox(height: 8),
                      _buildTextField(nameController, 'Masukkan nama layanan'),
                      const SizedBox(height: 16),
                      _buildFormLabel('Kategori'),
                      const SizedBox(height: 8),
                      _buildCategoryDropdown(selectedCategory, (value) {
                        setModalState(() => selectedCategory = value!);
                      }),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFormLabel('Harga Min'),
                                const SizedBox(height: 8),
                                _buildPriceField(minPriceController),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFormLabel('Harga Max'),
                                const SizedBox(height: 8),
                                _buildPriceField(maxPriceController),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildFormLabel('Durasi'),
                      const SizedBox(height: 8),
                      _buildDurationDropdown(selectedDuration, (value) {
                        setModalState(() => selectedDuration = value!);
                      }),
                      const SizedBox(height: 16),
                      _buildFormLabel('Deskripsi'),
                      const SizedBox(height: 8),
                      _buildTextField(descController, 'Deskripsi layanan', maxLines: 3),
                      const SizedBox(height: 16),
                      _buildFormLabel('Spare Part / Bahan'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          ...parts.map((part) => Chip(
                                label: Text(part, style: const TextStyle(fontSize: 12)),
                                deleteIcon: const Icon(Icons.close, size: 16),
                                onDeleted: () => setModalState(() => parts.remove(part)),
                                backgroundColor: AppTheme.primaryBlue.withOpacity(0.08),
                                side: BorderSide.none,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              )),
                          SizedBox(
                            width: 120,
                            height: 36,
                            child: TextField(
                              controller: partsController,
                              style: const TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                hintText: '+ Tambah',
                                hintStyle: TextStyle(fontSize: 12, color: AppTheme.primaryBlue.withOpacity(0.7)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(color: AppTheme.primaryBlue.withOpacity(0.3)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(color: AppTheme.primaryBlue.withOpacity(0.3)),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              onSubmitted: (value) {
                                if (value.trim().isNotEmpty) {
                                  setModalState(() {
                                    parts.add(value.trim());
                                    partsController.clear();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildToggleOption(
                              'Popular',
                              Icons.star_rounded,
                              isPopular,
                              (v) => setModalState(() => isPopular = v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildToggleOption(
                              'Promo',
                              Icons.local_offer_rounded,
                              isPromo,
                              (v) => setModalState(() => isPromo = v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Nama layanan tidak boleh kosong'),
                                  backgroundColor: const Color(0xFFEF4444),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              _services[index] = {
                                ..._services[index],
                                'name': nameController.text.trim(),
                                'category': selectedCategory,
                                'minPrice': int.tryParse(minPriceController.text) ?? service['minPrice'],
                                'maxPrice': int.tryParse(maxPriceController.text) ?? service['maxPrice'],
                                'duration': selectedDuration,
                                'description': descController.text.trim(),
                                'parts': parts,
                                'popular': isPopular,
                                'promo': isPromo,
                              };
                            });
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Layanan berhasil diperbarui'),
                                backgroundColor: AppTheme.successGreen,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Simpan Perubahan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> service, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 22),
            ),
            const SizedBox(width: 12),
            const Text('Hapus Layanan', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yakin ingin menghapus "${service['name']}"?',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Layanan yang dihapus tidak dapat dikembalikan.',
              style: TextStyle(fontSize: 12, color: AppTheme.textGrey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: TextStyle(color: AppTheme.textGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _services.removeAt(index));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${service['name']}" telah dihapus'),
                  backgroundColor: const Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() => _services.insert(index, service));
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddService(BuildContext context) {
    final nameController = TextEditingController();
    final minPriceController = TextEditingController();
    final maxPriceController = TextEditingController();
    final descController = TextEditingController();
    final partsController = TextEditingController();
    String selectedCategory = 'Rutin';
    String selectedDuration = '30 menit';
    bool isPopular = false;
    List<String> parts = [];
    bool showPreview = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.92,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tambah Layanan Baru',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Form content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showPreview) ...[
                        _buildPreviewCard(
                          nameController.text,
                          selectedCategory,
                          int.tryParse(minPriceController.text) ?? 0,
                          int.tryParse(maxPriceController.text) ?? 0,
                          selectedDuration,
                          isPopular,
                          descController.text,
                          parts,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => setModalState(() => showPreview = false),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  side: BorderSide(color: AppTheme.primaryBlue),
                                ),
                                child: const Text('Edit Lagi'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  final iconForCategory = _getIconForCategory(selectedCategory);
                                  setState(() {
                                    _services.add({
                                      'name': nameController.text.trim(),
                                      'category': selectedCategory,
                                      'minPrice': int.tryParse(minPriceController.text) ?? 0,
                                      'maxPrice': int.tryParse(maxPriceController.text) ?? 0,
                                      'duration': selectedDuration,
                                      'icon': iconForCategory,
                                      'popular': isPopular,
                                      'promo': false,
                                      'active': true,
                                      'customerCount': 0,
                                      'description': descController.text.trim(),
                                      'parts': parts,
                                    });
                                  });
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Layanan baru berhasil ditambahkan!'),
                                      backgroundColor: AppTheme.successGreen,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.successGreen,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        _buildFormLabel('Nama Layanan *'),
                        const SizedBox(height: 8),
                        _buildTextField(nameController, 'Contoh: Ganti Oli Mesin'),
                        const SizedBox(height: 16),
                        _buildFormLabel('Kategori *'),
                        const SizedBox(height: 8),
                        _buildCategoryDropdown(selectedCategory, (value) {
                          setModalState(() => selectedCategory = value!);
                        }),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFormLabel('Harga Min *'),
                                  const SizedBox(height: 8),
                                  _buildPriceField(minPriceController),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFormLabel('Harga Max *'),
                                  const SizedBox(height: 8),
                                  _buildPriceField(maxPriceController),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildFormLabel('Durasi *'),
                        const SizedBox(height: 8),
                        _buildDurationDropdown(selectedDuration, (value) {
                          setModalState(() => selectedDuration = value!);
                        }),
                        const SizedBox(height: 16),
                        _buildFormLabel('Deskripsi / Catatan'),
                        const SizedBox(height: 8),
                        _buildTextField(descController, 'Detail layanan yang diberikan...', maxLines: 3),
                        const SizedBox(height: 16),
                        _buildFormLabel('Spare Part / Bahan'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            ...parts.map((part) => Chip(
                                  label: Text(part, style: const TextStyle(fontSize: 12)),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () => setModalState(() => parts.remove(part)),
                                  backgroundColor: AppTheme.primaryBlue.withOpacity(0.08),
                                  side: BorderSide.none,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                )),
                            SizedBox(
                              width: 140,
                              height: 36,
                              child: TextField(
                                controller: partsController,
                                style: const TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                  hintText: '+ Tambah part',
                                  hintStyle: TextStyle(fontSize: 12, color: AppTheme.primaryBlue.withOpacity(0.7)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide(color: AppTheme.primaryBlue.withOpacity(0.3)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide(color: AppTheme.primaryBlue.withOpacity(0.3)),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                onSubmitted: (value) {
                                  if (value.trim().isNotEmpty) {
                                    setModalState(() {
                                      parts.add(value.trim());
                                      partsController.clear();
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildToggleOption(
                          'Tandai sebagai Popular',
                          Icons.star_rounded,
                          isPopular,
                          (v) => setModalState(() => isPopular = v),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  if (nameController.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Masukkan nama layanan terlebih dahulu'),
                                        backgroundColor: AppTheme.warningOrange,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                    );
                                    return;
                                  }
                                  setModalState(() => showPreview = true);
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  side: BorderSide(color: AppTheme.primaryBlue),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.preview_rounded, size: 18, color: AppTheme.primaryBlue),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Preview',
                                      style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (nameController.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Nama layanan wajib diisi'),
                                        backgroundColor: const Color(0xFFEF4444),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                    );
                                    return;
                                  }
                                  final iconForCategory = _getIconForCategory(selectedCategory);
                                  setState(() {
                                    _services.add({
                                      'name': nameController.text.trim(),
                                      'category': selectedCategory,
                                      'minPrice': int.tryParse(minPriceController.text) ?? 0,
                                      'maxPrice': int.tryParse(maxPriceController.text) ?? 0,
                                      'duration': selectedDuration,
                                      'icon': iconForCategory,
                                      'popular': isPopular,
                                      'promo': false,
                                      'active': true,
                                      'customerCount': 0,
                                      'description': descController.text.trim(),
                                      'parts': parts,
                                    });
                                  });
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Layanan baru berhasil ditambahkan!'),
                                      backgroundColor: AppTheme.successGreen,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryBlue,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewCard(
    String name,
    String category,
    int minPrice,
    int maxPrice,
    String duration,
    bool isPopular,
    String description,
    List<String> parts,
  ) {
    final categoryColor = _getCategoryColor(category);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.preview_rounded, size: 16, color: AppTheme.primaryBlue),
              const SizedBox(width: 6),
              const Text(
                'Preview Layanan',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_getIconForCategory(category), color: categoryColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name.isEmpty ? 'Nama Layanan' : name,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        if (isPopular) ...[
                          const SizedBox(width: 6),
                          _buildBadge('Popular', AppTheme.warningOrange),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: categoryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Rp ${_formatPrice(minPrice)} - ${_formatPrice(maxPrice)}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primaryBlue),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.schedule_rounded, size: 13, color: AppTheme.textGrey),
              const SizedBox(width: 4),
              Text(duration, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
            ],
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: AppTheme.textGrey.withOpacity(0.9)),
            ),
          ],
          if (parts.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: parts
                  .map((p) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(p, style: const TextStyle(fontSize: 10, color: AppTheme.textDark)),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Rutin':
        return Icons.oil_barrel;
      case 'Perbaikan':
        return Icons.build;
      case 'Modifikasi':
        return Icons.auto_awesome;
      case 'Darurat':
        return Icons.emergency;
      default:
        return Icons.miscellaneous_services;
    }
  }

  Widget _buildFormLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppTheme.textDark,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildPriceField(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        prefixText: 'Rp ',
        prefixStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark),
        hintText: '0',
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildCategoryDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.grey.shade50,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: const TextStyle(fontSize: 14, color: AppTheme.textDark),
          items: ['Rutin', 'Perbaikan', 'Modifikasi', 'Darurat']
              .map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(cat),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(cat),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDurationDropdown(String value, ValueChanged<String?> onChanged) {
    final durations = ['30 menit', '1 jam', '2 jam', '3 jam'];
    // Ensure the value exists in the list
    final safeValue = durations.contains(value) ? value : durations.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.grey.shade50,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: safeValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: const TextStyle(fontSize: 14, color: AppTheme.textDark),
          items: durations
              .map((d) => DropdownMenuItem(
                    value: d,
                    child: Row(
                      children: [
                        const Icon(Icons.schedule_rounded, size: 16, color: AppTheme.textGrey),
                        const SizedBox(width: 10),
                        Text(d),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildToggleOption(String label, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? AppTheme.primaryBlue.withOpacity(0.3) : Colors.grey.shade300,
        ),
        color: value ? AppTheme.primaryBlue.withOpacity(0.04) : Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: value ? AppTheme.warningOrange : AppTheme.textGrey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: value ? AppTheme.textDark : AppTheme.textGrey,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppTheme.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
