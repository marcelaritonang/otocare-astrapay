import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';

class AppointmentTab extends StatefulWidget {
  const AppointmentTab({super.key});

  @override
  State<AppointmentTab> createState() => _AppointmentTabState();
}

class _AppointmentTabState extends State<AppointmentTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _pendingBookings = [
    {
      'id': 'BK001',
      'customer': 'Budi Santoso',
      'phone': '0812-3456-7890',
      'motor': 'Honda Vario 160',
      'plate': 'D 1234 ABC',
      'service': 'Ganti Oli + Tune Up',
      'timeSlot': '09:00 - 10:00',
      'estimatedCost': 185000,
      'status': 'pending',
      'avatar': 'B',
      'deposit': 10000,
      'bookingCode': 'OTC-8294751',
      'queue': 1,
    },
    {
      'id': 'BK002',
      'customer': 'Siti Nurhaliza',
      'phone': '0857-9012-3456',
      'motor': 'Yamaha NMAX 155',
      'plate': 'D 5678 DEF',
      'service': 'Servis CVT + Roller',
      'timeSlot': '10:30 - 12:00',
      'estimatedCost': 350000,
      'status': 'pending',
      'avatar': 'S',
      'deposit': 10000,
      'bookingCode': 'OTC-8294752',
      'queue': 2,
    },
    {
      'id': 'BK003',
      'customer': 'Reza Mahendra',
      'phone': '0878-1234-5678',
      'motor': 'Honda Beat Street',
      'plate': 'D 9012 GHI',
      'service': 'Ganti Kampas Rem Depan',
      'timeSlot': '13:00 - 13:45',
      'estimatedCost': 120000,
      'status': 'pending',
      'avatar': 'R',
      'deposit': 10000,
      'bookingCode': 'OTC-8294753',
      'queue': 3,
    },
  ];

  final List<Map<String, dynamic>> _confirmedBookings = [
    {
      'id': 'BK004',
      'customer': 'Andi Pratama',
      'phone': '0813-7890-1234',
      'motor': 'Honda PCX 160',
      'plate': 'D 3456 JKL',
      'service': 'Ganti Oli + Filter Udara',
      'timeSlot': '08:00 - 08:45',
      'estimatedCost': 130000,
      'status': 'confirmed',
      'avatar': 'A',
    },
    {
      'id': 'BK005',
      'customer': 'Ratna Dewi',
      'phone': '0821-5678-9012',
      'motor': 'Honda Scoopy 2023',
      'plate': 'D 7890 MNO',
      'service': 'Servis Berkala 10.000km',
      'timeSlot': '14:00 - 15:30',
      'estimatedCost': 250000,
      'status': 'confirmed',
      'avatar': 'R',
    },
  ];

  final List<Map<String, dynamic>> _completedBookings = [
    {
      'id': 'BK006',
      'customer': 'Dewi Lestari',
      'phone': '0856-3456-7890',
      'motor': 'Yamaha Aerox 155',
      'plate': 'D 2345 PQR',
      'service': 'Ganti Oli + Busi',
      'timeSlot': '08:00 - 08:30',
      'estimatedCost': 95000,
      'actualCost': 95000,
      'status': 'completed',
      'avatar': 'D',
      'paymentMethod': 'QRIS AstraPay',
    },
    {
      'id': 'BK007',
      'customer': 'Fajar Nugroho',
      'phone': '0899-1234-5678',
      'motor': 'Honda ADV 160',
      'plate': 'D 6789 STU',
      'service': 'Tune Up + Ganti Filter',
      'timeSlot': '09:00 - 10:00',
      'estimatedCost': 175000,
      'actualCost': 200000,
      'status': 'completed',
      'avatar': 'F',
      'paymentMethod': 'Cash',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'id_ID');
    return 'Rp ${formatter.format(amount)}';
  }

  int get _todayRevenue {
    int total = 0;
    for (var booking in _completedBookings) {
      total += (booking['actualCost'] as int?) ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: RefreshIndicator(
              color: AppTheme.primaryBlue,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildStatsRow(),
                    _buildTabSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {});
  }

  Widget _buildHeader() {
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(now);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.3),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Manajemen Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateStr,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              _buildScanQRButton(),
              const SizedBox(width: 10),
              _buildNotificationBell(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScanQRButton() {
    return GestureDetector(
      onTap: () => _showScanQRDialog(),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 24),
      ),
    );
  }

  void _showScanQRDialog() {
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
            const SizedBox(height: 20),
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.qr_code_scanner, color: AppTheme.primaryBlue, size: 36),
            ),
            const SizedBox(height: 16),
            const Text('Scan QR Booking', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 8),
            const Text(
              'Scan QR code dari customer untuk verifikasi kehadiran dan check-in',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.4),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _simulateQRScan();
                },
                icon: const Icon(Icons.camera_alt, size: 18),
                label: const Text('Buka Kamera'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _showManualCodeEntry();
                },
                icon: const Icon(Icons.keyboard, size: 18),
                label: const Text('Input Kode Manual'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _simulateQRScan() {
    // Simulate scanning the first pending booking
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_pendingBookings.isNotEmpty) {
        _showCheckInSuccess(_pendingBookings[0]);
      }
    });
  }

  void _showManualCodeEntry() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Input Kode Booking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        content: TextField(
          controller: controller,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            hintText: 'Contoh: OTC-8294751',
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              final code = controller.text.trim();
              final found = _pendingBookings.where((b) => b['bookingCode'] == code).toList();
              if (found.isNotEmpty) {
                _showCheckInSuccess(found[0]);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Kode "$code" tidak ditemukan'), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
            child: const Text('Verifikasi', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showCheckInSuccess(Map<String, dynamic> booking) {
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
              child: const Icon(Icons.verified, color: AppTheme.successGreen, size: 42),
            ),
            const SizedBox(height: 16),
            const Text('Check-in Berhasil ✓', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  _checkInRow('Customer', booking['customer']),
                  _checkInRow('Motor', booking['motor']),
                  _checkInRow('Plat', booking['plate']),
                  _checkInRow('Layanan', booking['service']),
                  _checkInRow('Slot', booking['timeSlot']),
                  _checkInRow('Kode', booking['bookingCode']),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Deposit', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                        child: Text('Rp 10.000 ✓ Refund', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.successGreen)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _pendingBookings.remove(booking);
                    booking['status'] = 'confirmed';
                    _confirmedBookings.add(booking);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${booking['customer']} sudah check-in. Deposit dikembalikan.'),
                      backgroundColor: AppTheme.successGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.successGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Konfirmasi & Mulai Servis', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _checkInRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  Widget _buildNotificationBell() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('3 notifikasi baru'),
            backgroundColor: AppTheme.primaryBlue,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          _buildStatCard(
            icon: Icons.calendar_today_rounded,
            label: "Hari Ini",
            value: '${_pendingBookings.length + _confirmedBookings.length + _completedBookings.length}',
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(width: 10),
          _buildStatCard(
            icon: Icons.hourglass_top_rounded,
            label: "Pending",
            value: '${_pendingBookings.length}',
            color: AppTheme.warningOrange,
          ),
          const SizedBox(width: 10),
          _buildStatCard(
            icon: Icons.check_circle_outline_rounded,
            label: "Selesai",
            value: '${_completedBookings.length}',
            color: AppTheme.successGreen,
          ),
          const SizedBox(width: 10),
          _buildStatCard(
            icon: Icons.account_balance_wallet_rounded,
            label: "Revenue",
            value: _formatCompactCurrency(_todayRevenue),
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  String _formatCompactCurrency(int amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}jt';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}rb';
    }
    return '$amount';
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryBlue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            labelColor: Colors.white,
            unselectedLabelColor: AppTheme.textGrey,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Menunggu'),
                    if (_pendingBookings.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${_pendingBookings.length}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Tab(text: 'Dikonfirmasi'),
              const Tab(text: 'Selesai'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: _calculateTabContentHeight(),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildBookingListContent(_pendingBookings, 'pending'),
              _buildBookingListContent(_confirmedBookings, 'confirmed'),
              _buildBookingListContent(_completedBookings, 'completed'),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateTabContentHeight() {
    final maxItems = [
      _pendingBookings.length,
      _confirmedBookings.length,
      _completedBookings.length,
    ].reduce((a, b) => a > b ? a : b);

    if (maxItems == 0) return 300;
    return (maxItems * 200.0) + 40;
  }

  Widget _buildBookingListContent(
      List<Map<String, dynamic>> bookings, String type) {
    if (bookings.isEmpty) {
      return _buildEmptyState(type);
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(bookings[index], type);
      },
    );
  }

  Widget _buildEmptyState(String type) {
    String message;
    IconData icon;
    switch (type) {
      case 'pending':
        message = 'Tidak ada booking yang menunggu konfirmasi';
        icon = Icons.inbox_rounded;
        break;
      case 'confirmed':
        message = 'Belum ada booking yang dikonfirmasi hari ini';
        icon = Icons.event_available_rounded;
        break;
      case 'completed':
        message = 'Belum ada booking yang selesai hari ini';
        icon = Icons.task_alt_rounded;
        break;
      default:
        message = 'Tidak ada data';
        icon = Icons.hourglass_empty_rounded;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: AppTheme.primaryBlue.withOpacity(0.4)),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textGrey.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Tarik ke bawah untuk memperbarui',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, String type) {
    Color statusColor;
    String statusLabel;
    switch (type) {
      case 'pending':
        statusColor = AppTheme.warningOrange;
        statusLabel = 'Menunggu';
        break;
      case 'confirmed':
        statusColor = AppTheme.primaryBlue;
        statusLabel = 'Dikonfirmasi';
        break;
      case 'completed':
        statusColor = AppTheme.successGreen;
        statusLabel = 'Selesai';
        break;
      default:
        statusColor = AppTheme.textGrey;
        statusLabel = 'Unknown';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: type == 'pending'
              ? statusColor.withOpacity(0.3)
              : Colors.grey.shade100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer info row
            Row(
              children: [
                _buildAvatar(booking['avatar'] ?? '?', statusColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['customer'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined,
                              size: 12, color: AppTheme.textGrey),
                          const SizedBox(width: 4),
                          Text(
                            booking['phone'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(statusLabel, statusColor),
              ],
            ),
            const SizedBox(height: 14),

            // Vehicle info
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.backgroundWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.two_wheeler_rounded,
                      size: 18, color: AppTheme.primaryBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['motor'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        Text(
                          booking['plate'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: 13, color: AppTheme.primaryBlue),
                        const SizedBox(width: 4),
                        Text(
                          booking['timeSlot'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Service and cost
            Row(
              children: [
                Icon(Icons.build_circle_outlined,
                    size: 16, color: AppTheme.textGrey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    booking['service'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
                Text(
                  type == 'completed'
                      ? _formatCurrency(booking['actualCost'] as int)
                      : _formatCurrency(booking['estimatedCost'] as int),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: type == 'completed'
                        ? AppTheme.successGreen
                        : AppTheme.textDark,
                  ),
                ),
              ],
            ),

            // Payment method for completed
            if (type == 'completed' && booking['paymentMethod'] != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    booking['paymentMethod'] == 'QRIS AstraPay'
                        ? Icons.qr_code_rounded
                        : Icons.payments_outlined,
                    size: 14,
                    color: AppTheme.successGreen,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Dibayar via ${booking['paymentMethod']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.successGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],

            // Deposit & queue info for pending
            if (type == 'pending' && booking['deposit'] != null) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, size: 14, color: Colors.amber.shade700),
                    const SizedBox(width: 6),
                    Text('Deposit: Rp ${_formatCompactCurrency(booking['deposit'] as int)}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.amber.shade700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text('Antrian #${booking['queue']}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.primaryBlue)),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)),
                      child: Text('${booking['bookingCode']}', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppTheme.textGrey)),
                    ),
                  ],
                ),
              ),
            ],

            // Action buttons
            if (type != 'completed') ...[
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 12),
              _buildActionButtons(booking, type),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String letter, Color color) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.8), color],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> booking, String type) {
    if (type == 'pending') {
      return Row(
        children: [
          // Chat button
          _buildIconActionButton(
            icon: Icons.chat_bubble_outline_rounded,
            color: AppTheme.primaryBlue,
            onTap: () => _openChat(booking),
          ),
          const SizedBox(width: 10),
          // Reject button
          Expanded(
            child: _buildActionButton(
              label: 'Tolak',
              icon: Icons.close_rounded,
              color: Colors.red,
              isOutlined: true,
              onTap: () => _rejectBooking(booking),
            ),
          ),
          const SizedBox(width: 10),
          // Confirm button
          Expanded(
            flex: 2,
            child: _buildActionButton(
              label: 'Konfirmasi',
              icon: Icons.check_rounded,
              color: AppTheme.successGreen,
              isOutlined: false,
              onTap: () => _confirmBooking(booking),
            ),
          ),
        ],
      );
    } else if (type == 'confirmed') {
      return Row(
        children: [
          // Chat button
          _buildIconActionButton(
            icon: Icons.chat_bubble_outline_rounded,
            color: AppTheme.primaryBlue,
            onTap: () => _openChat(booking),
          ),
          const SizedBox(width: 10),
          // Complete button
          Expanded(
            child: _buildActionButton(
              label: 'Tandai Selesai',
              icon: Icons.task_alt_rounded,
              color: AppTheme.primaryBlue,
              isOutlined: false,
              onTap: () => _showCompleteBottomSheet(booking),
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildIconActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required bool isOutlined,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.transparent : color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color, width: isOutlined ? 1.5 : 0),
            boxShadow: isOutlined
                ? null
                : [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16, color: isOutlined ? color : Colors.white),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isOutlined ? color : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Actions ---

  void _openChat(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Membuka chat dengan ${booking['customer']}...'),
        backgroundColor: AppTheme.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _confirmBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: AppTheme.successGreen, size: 22),
            ),
            const SizedBox(width: 12),
            const Text('Konfirmasi Booking',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDialogInfoRow(
                Icons.person_outlined, booking['customer']),
            const SizedBox(height: 8),
            _buildDialogInfoRow(
                Icons.two_wheeler_rounded, '${booking['motor']} (${booking['plate']})'),
            const SizedBox(height: 8),
            _buildDialogInfoRow(
                Icons.build_outlined, booking['service']),
            const SizedBox(height: 8),
            _buildDialogInfoRow(Icons.access_time_rounded,
                booking['timeSlot']),
            const SizedBox(height: 8),
            _buildDialogInfoRow(Icons.payments_outlined,
                'Estimasi: ${_formatCurrency(booking['estimatedCost'] as int)}'),
            const SizedBox(height: 16),
            Text(
              'Konfirmasi booking ini? Pelanggan akan menerima notifikasi.',
              style: TextStyle(fontSize: 13, color: AppTheme.textGrey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal',
                style: TextStyle(color: AppTheme.textGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _pendingBookings.remove(booking);
                booking['status'] = 'confirmed';
                _confirmedBookings.add(booking);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Booking ${booking['customer']} berhasil dikonfirmasi'),
                  backgroundColor: AppTheme.successGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Konfirmasi',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _rejectBooking(Map<String, dynamic> booking) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.cancel_rounded,
                  color: Colors.red, size: 22),
            ),
            const SizedBox(width: 12),
            const Text('Tolak Booking',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking dari ${booking['customer']} akan ditolak.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              '${booking['motor']} - ${booking['service']}',
              style: const TextStyle(fontSize: 13, color: AppTheme.textGrey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                labelText: 'Alasan penolakan',
                hintText: 'Contoh: Jadwal penuh, spare part habis',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                isDense: true,
                prefixIcon: const Icon(Icons.comment_outlined, size: 20),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal',
                style: TextStyle(color: AppTheme.textGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _pendingBookings.remove(booking);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Booking ${booking['customer']} telah ditolak'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child:
                const Text('Tolak', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textGrey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: const TextStyle(fontSize: 13, color: AppTheme.textDark)),
        ),
      ],
    );
  }

  void _showCompleteBottomSheet(Map<String, dynamic> booking) {
    final services = [
      {'name': booking['service'], 'checked': true},
      {'name': 'Cek Kelistrikan', 'checked': false},
      {'name': 'Pembersihan Karburator', 'checked': false},
      {'name': 'Ganti Busi', 'checked': false},
      {'name': 'Cek Rem & Kampas', 'checked': false},
    ];

    final costController = TextEditingController(
      text: (booking['estimatedCost'] as int).toString(),
    );

    String selectedPayment = 'QRIS AstraPay';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.receipt_long_rounded,
                              color: AppTheme.primaryBlue, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selesaikan Servis',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              Text(
                                '${booking['customer']} - ${booking['motor']}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(ctx),
                          icon: const Icon(Icons.close_rounded),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Services done
                          const Text(
                            'Servis yang Dikerjakan',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...services.asMap().entries.map((entry) {
                            final index = entry.key;
                            final service = entry.value;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: (service['checked'] as bool)
                                    ? AppTheme.primaryBlue.withOpacity(0.04)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: (service['checked'] as bool)
                                      ? AppTheme.primaryBlue.withOpacity(0.2)
                                      : Colors.grey.shade200,
                                ),
                              ),
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                title: Text(
                                  service['name'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textDark,
                                    fontWeight: (service['checked'] as bool)
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                                value: service['checked'] as bool,
                                activeColor: AppTheme.primaryBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                onChanged: (val) {
                                  setModalState(() {
                                    services[index]['checked'] = val ?? false;
                                  });
                                },
                              ),
                            );
                          }),
                          const SizedBox(height: 20),

                          // Actual cost
                          const Text(
                            'Biaya Aktual',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: costController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: 'Rp ',
                              prefixStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textDark,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: AppTheme.primaryBlue, width: 1.5),
                              ),
                              filled: true,
                              fillColor: AppTheme.backgroundWhite,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Estimasi awal: ${_formatCurrency(booking['estimatedCost'] as int)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textGrey,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Payment method
                          const Text(
                            'Metode Pembayaran',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildPaymentOption(
                            icon: Icons.qr_code_rounded,
                            label: 'QRIS AstraPay',
                            subtitle: 'Pembayaran digital, langsung masuk',
                            isSelected: selectedPayment == 'QRIS AstraPay',
                            color: AppTheme.primaryBlue,
                            onTap: () {
                              setModalState(() {
                                selectedPayment = 'QRIS AstraPay';
                              });
                            },
                          ),
                          const SizedBox(height: 8),
                          _buildPaymentOption(
                            icon: Icons.payments_outlined,
                            label: 'Cash',
                            subtitle: 'Pembayaran tunai',
                            isSelected: selectedPayment == 'Cash',
                            color: AppTheme.successGreen,
                            onTap: () {
                              setModalState(() {
                                selectedPayment = 'Cash';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bottom button
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          final actualCost =
                              int.tryParse(costController.text) ??
                                  (booking['estimatedCost'] as int);
                          setState(() {
                            _confirmedBookings.remove(booking);
                            booking['status'] = 'completed';
                            booking['actualCost'] = actualCost;
                            booking['paymentMethod'] = selectedPayment;
                            _completedBookings.add(booking);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle_rounded,
                                      color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Servis ${booking['customer']} selesai - ${_formatCurrency(actualCost)}',
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: AppTheme.successGreen,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                          shadowColor:
                              AppTheme.primaryBlue.withOpacity(0.4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              selectedPayment == 'QRIS AstraPay'
                                  ? Icons.qr_code_rounded
                                  : Icons.payments_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Minta Pembayaran',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String label,
    required String subtitle,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: color, size: 22)
            else
              Icon(Icons.radio_button_off_rounded,
                  color: Colors.grey.shade300, size: 22),
          ],
        ),
      ),
    );
  }
}
