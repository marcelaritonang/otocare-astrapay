import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ReminderTab extends StatefulWidget {
  const ReminderTab({super.key});

  @override
  State<ReminderTab> createState() => _ReminderTabState();
}

class _ReminderTabState extends State<ReminderTab> {
  final List<Map<String, dynamic>> _reminders = [
    {
      'title': 'Ganti Oli Mesin',
      'lastDate': '15 Mar 2026',
      'nextDate': '15 Jun 2026',
      'interval': 'Setiap 3 bulan / 5.000 km',
      'intervalDays': 90,
      'intervalKm': 5000,
      'daysLeft': 5,
      'status': 'urgent',
      'icon': Icons.oil_barrel,
    },
    {
      'title': 'Kampas Rem Depan',
      'lastDate': '20 Jan 2026',
      'nextDate': '20 Jul 2026',
      'interval': 'Setiap 6 bulan / 10.000 km',
      'intervalDays': 180,
      'intervalKm': 10000,
      'daysLeft': 40,
      'status': 'upcoming',
      'icon': Icons.disc_full,
    },
    {
      'title': 'Busi',
      'lastDate': '05 Des 2025',
      'nextDate': '05 Jun 2026',
      'interval': 'Setiap 6 bulan / 12.000 km',
      'intervalDays': 180,
      'intervalKm': 12000,
      'daysLeft': -5,
      'status': 'overdue',
      'icon': Icons.electric_bolt,
    },
    {
      'title': 'Filter Udara',
      'lastDate': '02 Agu 2025',
      'nextDate': '02 Feb 2026',
      'interval': 'Setiap 6 bulan / 8.000 km',
      'intervalDays': 180,
      'intervalKm': 8000,
      'daysLeft': -120,
      'status': 'overdue',
      'icon': Icons.air,
    },
    {
      'title': 'V-Belt',
      'lastDate': '02 Agu 2025',
      'nextDate': '02 Feb 2027',
      'interval': 'Setiap 18 bulan / 25.000 km',
      'intervalDays': 540,
      'intervalKm': 25000,
      'daysLeft': 240,
      'status': 'normal',
      'icon': Icons.settings,
    },
    {
      'title': 'Aki / Baterai',
      'lastDate': '10 Nov 2024',
      'nextDate': '10 Nov 2026',
      'interval': 'Setiap 2 tahun',
      'intervalDays': 730,
      'intervalKm': 0,
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
    final overdueCount = _reminders.where((r) => r['status'] == 'overdue').length;
    final urgentCount = _reminders.where((r) => r['status'] == 'urgent').length;
    final normalCount = _reminders.where((r) => r['status'] == 'normal' || r['status'] == 'upcoming').length;

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
              _statusBadge('$overdueCount Overdue', Colors.red),
              const SizedBox(width: 8),
              _statusBadge('$urgentCount Segera', AppTheme.warningOrange),
              const SizedBox(width: 8),
              _statusBadge('$normalCount Normal', AppTheme.successGreen),
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
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildReminderList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAddReminderButton(context),
        const SizedBox(height: 12),
        ..._reminders.asMap().entries.map((entry) => _buildReminderCard(context, entry.value, entry.key)),
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: AppTheme.primaryBlue, size: 20),
            SizedBox(width: 8),
            Text('Tambah Reminder Baru', style: TextStyle(color: AppTheme.primaryBlue, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(BuildContext context, Map<String, dynamic> item, int index) {
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

    return Dismissible(
      key: Key('reminder_${item['title']}_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 22),
            SizedBox(width: 4),
            Text('Hapus', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Hapus Reminder', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            content: Text('Hapus reminder "${item['title']}"?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Hapus'),
              ),
            ],
          ),
        ) ?? false;
      },
      onDismissed: (direction) {
        setState(() {
          _reminders.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reminder "${item['title']}" dihapus'),
            backgroundColor: AppTheme.textDark,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            action: SnackBarAction(
              label: 'Undo',
              textColor: AppTheme.primaryBlue,
              onPressed: () {
                setState(() {
                  _reminders.insert(index, item);
                });
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _showReminderDetail(context, item, index),
        child: Container(
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
        ),
      ),
    );
  }

  void _showReminderDetail(BuildContext context, Map<String, dynamic> item, int index) {
    Color statusColor;
    switch (item['status']) {
      case 'overdue':
        statusColor = Colors.red;
        break;
      case 'urgent':
        statusColor = AppTheme.warningOrange;
        break;
      case 'upcoming':
        statusColor = AppTheme.primaryBlue;
        break;
      default:
        statusColor = AppTheme.successGreen;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(item['icon'], color: statusColor, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                      Text(item['interval'], style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 16),
            _detailRow('Terakhir Service', item['lastDate']),
            _detailRow('Jadwal Berikutnya', item['nextDate']),
            _detailRow('Interval Waktu', '${item['intervalDays']} hari'),
            if ((item['intervalKm'] as int) > 0)
              _detailRow('Interval KM', '${item['intervalKm']} km'),
            _detailRow('Status', item['status'] == 'overdue' ? 'Terlambat' : item['status'] == 'urgent' ? 'Segera' : 'Normal'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _showEditReminder(context, item, index);
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _deleteReminder(context, item, index);
                    },
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Hapus'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textDark))),
        ],
      ),
    );
  }

  void _deleteReminder(BuildContext context, Map<String, dynamic> item, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Reminder', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Text('Yakin ingin menghapus reminder "${item['title']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _reminders.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Reminder "${item['title']}" dihapus'),
                  backgroundColor: AppTheme.textDark,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showEditReminder(BuildContext context, Map<String, dynamic> item, int index) {
    final titleController = TextEditingController(text: item['title']);
    final intervalDaysController = TextEditingController(text: '${item['intervalDays']}');
    final intervalKmController = TextEditingController(text: '${item['intervalKm']}');

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
              const Text('Edit Reminder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Nama Service',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: intervalDaysController,
                decoration: InputDecoration(
                  labelText: 'Interval (hari)',
                  hintText: 'e.g. 90',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: intervalKmController,
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
                  onPressed: () {
                    final days = int.tryParse(intervalDaysController.text) ?? item['intervalDays'];
                    final km = int.tryParse(intervalKmController.text) ?? item['intervalKm'];
                    setState(() {
                      _reminders[index] = {
                        ...item,
                        'title': titleController.text.isNotEmpty ? titleController.text : item['title'],
                        'intervalDays': days,
                        'intervalKm': km,
                        'interval': km > 0 ? 'Setiap $days hari / ${_formatKm(km)} km' : 'Setiap $days hari',
                      };
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Reminder berhasil diupdate'),
                        backgroundColor: AppTheme.successGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text('Simpan Perubahan'),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddReminder(BuildContext context) {
    String? selectedService;
    DateTime? selectedDate;
    final intervalDaysController = TextEditingController();
    final intervalKmController = TextEditingController();

    final serviceTypes = [
      'Ganti Oli',
      'Tune Up',
      'Ganti Kampas Rem',
      'Ganti Ban',
      'Servis CVT',
      'Ganti V-Belt',
      'Ganti Busi',
      'Ganti Filter Udara',
      'Ganti Aki',
      'Servis Injeksi',
      'Lainnya',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
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
                const SizedBox(height: 6),
                const Text('Atur jadwal perawatan motor kamu', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                const SizedBox(height: 20),
                // Service type dropdown
                DropdownButtonFormField<String>(
                  value: selectedService,
                  decoration: InputDecoration(
                    labelText: 'Jenis Service',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  items: serviceTypes.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 14)))).toList(),
                  onChanged: (val) => setModalState(() => selectedService = val),
                ),
                const SizedBox(height: 12),
                // Last service date picker
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                      helpText: 'Pilih tanggal service terakhir',
                    );
                    if (picked != null) {
                      setModalState(() => selectedDate = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Tanggal Service Terakhir',
                            style: TextStyle(
                              fontSize: 14,
                              color: selectedDate != null ? AppTheme.textDark : AppTheme.textGrey,
                            ),
                          ),
                        ),
                        const Icon(Icons.calendar_today, color: AppTheme.textGrey, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Interval days
                TextField(
                  controller: intervalDaysController,
                  decoration: InputDecoration(
                    labelText: 'Interval (hari)',
                    hintText: 'e.g. 90 (3 bulan)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                // Interval km
                TextField(
                  controller: intervalKmController,
                  decoration: InputDecoration(
                    labelText: 'Interval (km) - opsional',
                    hintText: 'e.g. 5000',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedService == null || selectedDate == null || intervalDaysController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Mohon lengkapi semua field wajib'),
                            backgroundColor: AppTheme.warningOrange,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                        return;
                      }

                      final days = int.tryParse(intervalDaysController.text) ?? 90;
                      final km = int.tryParse(intervalKmController.text) ?? 0;
                      final nextDate = selectedDate!.add(Duration(days: days));
                      final daysLeft = nextDate.difference(DateTime.now()).inDays;

                      String status;
                      if (daysLeft < 0) {
                        status = 'overdue';
                      } else if (daysLeft <= 7) {
                        status = 'urgent';
                      } else if (daysLeft <= 30) {
                        status = 'upcoming';
                      } else {
                        status = 'normal';
                      }

                      final intervalText = km > 0 ? 'Setiap $days hari / ${_formatKm(km)} km' : 'Setiap $days hari';

                      setState(() {
                        _reminders.add({
                          'title': selectedService,
                          'lastDate': _formatDate(selectedDate!),
                          'nextDate': _formatDate(nextDate),
                          'interval': intervalText,
                          'intervalDays': days,
                          'intervalKm': km,
                          'daysLeft': daysLeft,
                          'status': status,
                          'icon': _iconForService(selectedService!),
                        });
                      });

                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Reminder "$selectedService" berhasil ditambahkan'),
                          backgroundColor: AppTheme.successGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('Simpan Reminder'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  String _formatKm(int km) {
    if (km >= 1000) {
      return '${(km / 1000).toStringAsFixed(km % 1000 == 0 ? 0 : 1)}.000';
    }
    return '$km';
  }

  IconData _iconForService(String service) {
    switch (service) {
      case 'Ganti Oli':
        return Icons.oil_barrel;
      case 'Tune Up':
        return Icons.tune;
      case 'Ganti Kampas Rem':
        return Icons.disc_full;
      case 'Ganti Ban':
        return Icons.tire_repair;
      case 'Servis CVT':
        return Icons.settings;
      case 'Ganti V-Belt':
        return Icons.settings;
      case 'Ganti Busi':
        return Icons.electric_bolt;
      case 'Ganti Filter Udara':
        return Icons.air;
      case 'Ganti Aki':
        return Icons.battery_full;
      case 'Servis Injeksi':
        return Icons.local_gas_station;
      default:
        return Icons.build;
    }
  }
}
