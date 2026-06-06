import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ReminderTab extends StatelessWidget {
  const ReminderTab({super.key});

  final List<Map<String, dynamic>> _reminders = const [
    {
      'title': 'Ganti Oli Mesin',
      'lastDate': '15 Mar 2026',
      'nextDate': '15 Jun 2026',
      'interval': 'Setiap 3 bulan / 5.000 km',
      'daysLeft': 5,
      'status': 'urgent',
      'icon': Icons.oil_barrel,
    },
    {
      'title': 'Kampas Rem Depan',
      'lastDate': '20 Jan 2026',
      'nextDate': '20 Jul 2026',
      'interval': 'Setiap 6 bulan / 10.000 km',
      'daysLeft': 40,
      'status': 'upcoming',
      'icon': Icons.disc_full,
    },
    {
      'title': 'Busi',
      'lastDate': '05 Des 2025',
      'nextDate': '05 Jun 2026',
      'interval': 'Setiap 6 bulan / 12.000 km',
      'daysLeft': -5,
      'status': 'overdue',
      'icon': Icons.electric_bolt,
    },
    {
      'title': 'Filter Udara',
      'lastDate': '02 Agu 2025',
      'nextDate': '02 Feb 2026',
      'interval': 'Setiap 6 bulan / 8.000 km',
      'daysLeft': -120,
      'status': 'overdue',
      'icon': Icons.air,
    },
    {
      'title': 'V-Belt',
      'lastDate': '02 Agu 2025',
      'nextDate': '02 Feb 2027',
      'interval': 'Setiap 18 bulan / 25.000 km',
      'daysLeft': 240,
      'status': 'normal',
      'icon': Icons.settings,
    },
    {
      'title': 'Aki / Baterai',
      'lastDate': '10 Nov 2024',
      'nextDate': '10 Nov 2026',
      'interval': 'Setiap 2 tahun',
      'daysLeft': 150,
      'status': 'normal',
      'icon': Icons.battery_full,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildReminderList(context)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reminder Service', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Jadwal perawatan motor kamu', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
          const SizedBox(height: 14),
          Row(
            children: [
              _statusBadge('2 Overdue', Colors.red),
              const SizedBox(width: 8),
              _statusBadge('1 Segera', AppTheme.warningOrange),
              const SizedBox(width: 8),
              _statusBadge('3 Normal', AppTheme.successGreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildReminderList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAddReminderButton(context),
        const SizedBox(height: 12),
        ..._reminders.map((r) => _buildReminderCard(context, r)),
      ],
    );
  }

  Widget _buildAddReminderButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddReminder(context),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2), style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: AppTheme.primaryBlue, size: 20),
            const SizedBox(width: 8),
            Text('Tambah Reminder Baru', style: TextStyle(color: AppTheme.primaryBlue, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(BuildContext context, Map<String, dynamic> item) {
    Color statusColor;
    String statusLabel;
    switch (item['status']) {
      case 'overdue':
        statusColor = Colors.red;
        statusLabel = 'Terlambat ${-(item['daysLeft'] as int)} hari';
        break;
      case 'urgent':
        statusColor = AppTheme.warningOrange;
        statusLabel = '${item['daysLeft']} hari lagi';
        break;
      case 'upcoming':
        statusColor = AppTheme.primaryBlue;
        statusLabel = '${item['daysLeft']} hari lagi';
        break;
      default:
        statusColor = AppTheme.successGreen;
        statusLabel = '${item['daysLeft']} hari lagi';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(item['icon'], color: statusColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                Text(item['interval'], style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                const SizedBox(height: 2),
                Text('Terakhir: ${item['lastDate']}', style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(statusLabel, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: statusColor)),
              ),
              const SizedBox(height: 4),
              Text(item['nextDate'], style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddReminder(BuildContext context) {
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
              const Text('Tambah Reminder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Service',
                  hintText: 'e.g. Ganti Oli',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Interval (bulan)',
                  hintText: 'e.g. 3',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Interval (km)',
                  hintText: 'e.g. 5000',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('Simpan Reminder'),
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
