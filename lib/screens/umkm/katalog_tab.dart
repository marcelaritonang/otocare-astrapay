import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class KatalogTab extends StatelessWidget {
  const KatalogTab({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'Ganti Oli', 'price': 'Rp 50.000 - 85.000', 'duration': '15 menit', 'icon': Icons.oil_barrel, 'popular': true},
    {'name': 'Tune Up', 'price': 'Rp 80.000 - 150.000', 'duration': '30 menit', 'icon': Icons.settings, 'popular': true},
    {'name': 'Servis Berkala', 'price': 'Rp 150.000 - 350.000', 'duration': '60 menit', 'icon': Icons.build, 'popular': false},
    {'name': 'Ganti Kampas Rem', 'price': 'Rp 80.000 - 120.000', 'duration': '20 menit', 'icon': Icons.disc_full, 'popular': false},
    {'name': 'Ganti V-Belt', 'price': 'Rp 150.000 - 280.000', 'duration': '45 menit', 'icon': Icons.settings_suggest, 'popular': false},
    {'name': 'Ganti Busi', 'price': 'Rp 30.000 - 60.000', 'duration': '10 menit', 'icon': Icons.electric_bolt, 'popular': false},
    {'name': 'Ganti Ban', 'price': 'Rp 150.000 - 350.000', 'duration': '20 menit', 'icon': Icons.tire_repair, 'popular': false},
    {'name': 'Rantai & Gear Set', 'price': 'Rp 200.000 - 450.000', 'duration': '30 menit', 'icon': Icons.link, 'popular': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(child: _buildServiceList(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Katalog & Layanan', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => _showAddService(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text('Tambah', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Kelola daftar layanan bengkel kamu', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildServiceList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
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
                child: Icon(service['icon'] as IconData, color: AppTheme.primaryBlue, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(service['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                        if (service['popular'] == true) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppTheme.warningOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                            child: const Text('Popular', style: TextStyle(fontSize: 9, color: AppTheme.warningOrange, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(service['price'], style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
                    Text('⏱ ${service['duration']}', style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: AppTheme.textGrey, size: 20),
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Hapus')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddService(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              const Text('Tambah Layanan Baru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'Nama Layanan', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'Harga Min (Rp)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), keyboardType: TextInputType.number)),
                  const SizedBox(width: 12),
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'Harga Max (Rp)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 12),
              TextField(decoration: InputDecoration(labelText: 'Durasi (menit)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('Simpan Layanan'),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
