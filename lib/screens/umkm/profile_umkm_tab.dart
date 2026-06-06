import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileUmkmTab extends StatelessWidget {
  const ProfileUmkmTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildProfileInfo(),
            _buildLocationSection(),
            _buildOperationalHours(),
            _buildPaymentMethods(),
            _buildAstraPaySection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('Profil Bisnis', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              GestureDetector(
                onTap: () => _showEditProfileModal(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text('Edit', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.store, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bengkel Jaya Motor', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Motor - All Brand', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text('4.8 (234 ulasan)', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
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

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Informasi Dasar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            const SizedBox(height: 12),
            _infoRow(Icons.person, 'Pemilik', 'Pak Budi Setiawan'),
            _infoRow(Icons.phone, 'Telepon', '0812-3456-7890'),
            _infoRow(Icons.email, 'Email', 'jayamotor@email.com'),
            _infoRow(Icons.badge, 'NIB', '1234567890123'),
            _infoRow(Icons.calendar_today, 'Bergabung', 'Juni 2026'),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lokasi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            const SizedBox(height: 12),
            _infoRow(Icons.location_on, 'Alamat', 'Jl. Raya Margahayu No. 15\nBandung, Jawa Barat 40286'),
            const SizedBox(height: 8),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F4E8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 32, color: AppTheme.primaryBlue.withOpacity(0.4)),
                        Text('Peta Lokasi', style: TextStyle(fontSize: 11, color: AppTheme.primaryBlue.withOpacity(0.6))),
                      ],
                    ),
                  ),
                  const Center(child: Icon(Icons.location_on, color: Colors.red, size: 28)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationalHours() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Jam Operasional', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: const Text('Buka', style: TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _scheduleRow('Senin - Jumat', '08:00 - 17:00'),
            _scheduleRow('Sabtu', '08:00 - 15:00'),
            _scheduleRow('Minggu', 'Tutup'),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Metode Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            const SizedBox(height: 12),
            Row(
              children: [
                _paymentBadge('QRIS AstraPay', AppTheme.primaryBlue, true),
                const SizedBox(width: 8),
                _paymentBadge('Cash', AppTheme.successGreen, true),
                const SizedBox(width: 8),
                _paymentBadge('Transfer', AppTheme.textGrey, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAstraPaySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.account_balance_wallet, color: AppTheme.primaryBlue, size: 20),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mitra AstraPay Bisnis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                      Text('Terverifikasi ✓', style: TextStyle(fontSize: 11, color: AppTheme.successGreen)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _astraPayStat('Saldo', 'Rp 3.5jt'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _astraPayStat('Bulan Ini', 'Rp 12.8jt'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _astraPayStat('Transaksi', '45'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showPinjamanModal(context),
                icon: const Icon(Icons.monetization_on, size: 16),
                label: const Text('Ajukan Pinjaman Modal', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryBlue,
                  side: const BorderSide(color: AppTheme.primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileModal(BuildContext context) {
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
              const Text('Edit Profil Bisnis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Nama Bengkel', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                controller: TextEditingController(text: 'Bengkel Jaya Motor'),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(labelText: 'Nama Pemilik', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                controller: TextEditingController(text: 'Pak Budi Setiawan'),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(labelText: 'Nomor Telepon', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                controller: TextEditingController(text: '0812-3456-7890'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                controller: TextEditingController(text: 'jayamotor@email.com'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(labelText: 'Alamat', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                controller: TextEditingController(text: 'Jl. Raya Margahayu No. 15, Bandung'),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profil berhasil diperbarui'),
                        backgroundColor: AppTheme.successGreen,
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

  void _showPinjamanModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.monetization_on, color: AppTheme.primaryBlue, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('Pinjaman Modal'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajukan pinjaman modal usaha melalui AstraPay Bisnis untuk mengembangkan bengkel kamu.',
              style: TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Keuntungan:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  SizedBox(height: 6),
                  Text('• Bunga rendah mulai 0.5%/bulan', style: TextStyle(fontSize: 12, color: AppTheme.textDark)),
                  Text('• Tenor fleksibel 3-12 bulan', style: TextStyle(fontSize: 12, color: AppTheme.textDark)),
                  Text('• Pencairan cepat ke saldo AstraPay', style: TextStyle(fontSize: 12, color: AppTheme.textDark)),
                  Text('• Tanpa jaminan hingga Rp 50jt', style: TextStyle(fontSize: 12, color: AppTheme.textDark)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Limit pinjaman kamu: Rp 25.000.000',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.primaryBlue),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pengajuan pinjaman modal sedang diproses'),
                  backgroundColor: AppTheme.primaryBlue,
                ),
              );
            },
            child: const Text('Ajukan Sekarang'),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 18),
          const SizedBox(width: 10),
          SizedBox(width: 70, child: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.textDark))),
        ],
      ),
    );
  }

  Widget _scheduleRow(String day, String time) {
    final isClosed = time == 'Tutup';
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontSize: 13, color: AppTheme.textDark)),
          Text(time, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isClosed ? Colors.red : AppTheme.textDark)),
        ],
      ),
    );
  }

  Widget _paymentBadge(String label, Color color, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? color.withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? color.withOpacity(0.3) : Colors.grey.shade300),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: active ? color : AppTheme.textGrey)),
    );
  }

  Widget _astraPayStat(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
        ],
      ),
    );
  }
}
