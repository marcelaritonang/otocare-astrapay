import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AppointmentTab extends StatefulWidget {
  const AppointmentTab({super.key});

  @override
  State<AppointmentTab> createState() => _AppointmentTabState();
}

class _AppointmentTabState extends State<AppointmentTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _todayBookings = [
    {
      'customer': 'Andi Pratama',
      'motor': 'Honda Vario 160',
      'service': 'Ganti Oli + Tune Up',
      'time': '09:00',
      'status': 'confirmed',
      'estimatedCost': 'Rp 185.000',
    },
    {
      'customer': 'Ratna Dewi',
      'motor': 'Honda Beat 2021',
      'service': 'Servis Berkala',
      'time': '10:30',
      'status': 'confirmed',
      'estimatedCost': 'Rp 250.000',
    },
    {
      'customer': 'Budi Santoso',
      'motor': 'Yamaha NMAX',
      'service': 'Ganti Kampas Rem',
      'time': '13:00',
      'status': 'pending',
      'estimatedCost': 'Rp 120.000',
    },
  ];

  final List<Map<String, dynamic>> _upcomingBookings = [
    {
      'customer': 'Dewi Lestari',
      'motor': 'Honda PCX 160',
      'service': 'CVT + Roller',
      'time': '08:30',
      'date': 'Besok, 12 Jun',
      'status': 'confirmed',
      'estimatedCost': 'Rp 350.000',
    },
    {
      'customer': 'Reza Mahendra',
      'motor': 'Yamaha Aerox',
      'service': 'Ganti Oli + Filter Udara',
      'time': '14:00',
      'date': 'Besok, 12 Jun',
      'status': 'pending',
      'estimatedCost': 'Rp 130.000',
    },
    {
      'customer': 'Siti Nurhaliza',
      'motor': 'Honda Scoopy',
      'service': 'Tune Up',
      'time': '09:00',
      'date': '13 Jun 2026',
      'status': 'pending',
      'estimatedCost': 'Rp 100.000',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          _buildStats(),
          _buildTabBar(),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.store, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Bengkel Jaya Motor', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                Text('Dashboard Booking', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                const Icon(Icons.notifications, color: Colors.white, size: 22),
                Positioned(
                  right: 0, top: 0,
                  child: Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _statCard('Hari Ini', '3', AppTheme.primaryBlue),
          const SizedBox(width: 10),
          _statCard('Pending', '2', AppTheme.warningOrange),
          const SizedBox(width: 10),
          _statCard('Selesai', '8', AppTheme.successGreen),
          const SizedBox(width: 10),
          _statCard('Minggu Ini', '15', Colors.purple),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 10, color: color), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppTheme.primaryBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.textGrey,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Hari Ini'),
          Tab(text: 'Mendatang'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildBookingList(_todayBookings, showDate: false),
        _buildBookingList(_upcomingBookings, showDate: true),
      ],
    );
  }

  Widget _buildBookingList(List<Map<String, dynamic>> bookings, {required bool showDate}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(booking, showDate: showDate);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, {required bool showDate}) {
    final isPending = booking['status'] == 'pending';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isPending ? AppTheme.warningOrange.withOpacity(0.3) : Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.person, color: AppTheme.primaryBlue, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking['customer'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    Text(booking['motor'], style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isPending ? AppTheme.warningOrange.withOpacity(0.1) : AppTheme.successGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isPending ? 'Pending' : 'Confirmed',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isPending ? AppTheme.warningOrange : AppTheme.successGreen),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(booking['time'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  if (showDate && booking['date'] != null)
                    Text(booking['date'], style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.06), borderRadius: BorderRadius.circular(6)),
                child: Text(booking['service'], style: TextStyle(fontSize: 11, color: AppTheme.primaryBlue)),
              ),
              const Spacer(),
              Text(booking['estimatedCost'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            ],
          ),
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text('Tolak', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _confirmBooking(booking),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.successGreen,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text('Konfirmasi', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _confirmBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${booking['customer']} - ${booking['motor']}'),
            const SizedBox(height: 8),
            Text('Layanan: ${booking['service']}'),
            Text('Estimasi: ${booking['estimatedCost']}'),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Harga final (opsional)',
                hintText: 'Rp ...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                isDense: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking ${booking['customer']} dikonfirmasi ✓'),
                  backgroundColor: AppTheme.successGreen,
                ),
              );
            },
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }
}
