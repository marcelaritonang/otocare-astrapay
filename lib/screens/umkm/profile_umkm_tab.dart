import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../theme/app_theme.dart';

class ProfileUmkmTab extends StatefulWidget {
  const ProfileUmkmTab({super.key});

  @override
  State<ProfileUmkmTab> createState() => _ProfileUmkmTabState();
}

class _ProfileUmkmTabState extends State<ProfileUmkmTab> {
  bool _isOperationalExpanded = false;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 16),
              _buildQuickStats(),
              const SizedBox(height: 16),
              _buildInformasiBengkel(context),
              const SizedBox(height: 16),
              _buildMetodePembayaran(context),
              const SizedBox(height: 16),
              _buildAstraPayBusiness(context),
              const SizedBox(height: 16),
              _buildFiturBisnis(context),
              const SizedBox(height: 16),
              _buildSettings(context),
              const SizedBox(height: 24),
              _buildFooter(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 1. PROFILE HEADER CARD
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        children: [
          // Top bar
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Profil Bisnis',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildEditButton(context),
            ],
          ),
          const SizedBox(height: 20),
          // Profile card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                // Bengkel photo placeholder
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.business_rounded, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 16),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bengkel Jaya Motor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '4.8 (234 ulasan)',
                            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'AstraPay Partner ✓',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: Colors.white.withOpacity(0.8), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Budi Santoso',
                            style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.successGreen.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified, color: Colors.white, size: 11),
                                SizedBox(width: 3),
                                Text(
                                  'Terverifikasi',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                                ),
                              ],
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
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEditProfileModal(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit_rounded, color: Colors.white, size: 14),
            SizedBox(width: 6),
            Text('Edit', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 2. QUICK STATS ROW
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _statCard('Total\nPelanggan', '1,250', Icons.people_alt_rounded, AppTheme.primaryBlue)),
          const SizedBox(width: 10),
          Expanded(child: _statCard('Transaksi\nBulan Ini', '89', Icons.receipt_long_rounded, AppTheme.successGreen)),
          const SizedBox(width: 10),
          Expanded(child: _statCard('Rating\nRata-rata', '4.8', Icons.star_rounded, AppTheme.warningOrange)),
          const SizedBox(width: 10),
          Expanded(child: _statCard('Pendapatan\n', 'Rp 4.8jt', Icons.trending_up_rounded, AppTheme.accentPink)),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 9, color: AppTheme.textGrey, height: 1.3),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 3. INFORMASI BENGKEL
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildInformasiBengkel(BuildContext context) {
    return _sectionCard(
      title: 'Informasi Bengkel',
      children: [
        _infoTile(
          icon: Icons.location_on_rounded,
          label: 'Alamat',
          value: 'Jl. Raya Margahayu No. 15, Bandung, Jawa Barat 40286',
          trailing: const Icon(Icons.map_rounded, size: 18, color: AppTheme.primaryBlue),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              _buildSnackBar('Membuka peta lokasi...'),
            );
          },
        ),
        const Divider(height: 1),
        _infoTile(
          icon: Icons.phone_rounded,
          label: 'Telepon',
          value: '0812-3456-7890',
          trailing: const Icon(Icons.copy_rounded, size: 16, color: AppTheme.primaryBlue),
          onTap: () {
            Clipboard.setData(const ClipboardData(text: '08123456789'));
            ScaffoldMessenger.of(context).showSnackBar(
              _buildSnackBar('Nomor telepon disalin ke clipboard'),
            );
          },
        ),
        const Divider(height: 1),
        _infoTile(
          icon: Icons.email_rounded,
          label: 'Email',
          value: 'jayamotor@email.com',
        ),
        const Divider(height: 1),
        _buildOperationalHours(),
        const Divider(height: 1),
        _infoTile(
          icon: Icons.calendar_month_rounded,
          label: 'Tahun Berdiri',
          value: '2018',
        ),
      ],
    );
  }

  Widget _buildOperationalHours() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isOperationalExpanded = !_isOperationalExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.access_time_rounded, color: AppTheme.primaryBlue, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jam Operasional',
                        style: TextStyle(fontSize: 12, color: AppTheme.textGrey),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text(
                            '08:00 - 17:00',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.successGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Buka',
                              style: TextStyle(fontSize: 10, color: AppTheme.successGreen, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: _isOperationalExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.textGrey),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(66, 0, 16, 14),
            child: Column(
              children: [
                _scheduleRow('Senin', '08:00 - 17:00'),
                _scheduleRow('Selasa', '08:00 - 17:00'),
                _scheduleRow('Rabu', '08:00 - 17:00'),
                _scheduleRow('Kamis', '08:00 - 17:00'),
                _scheduleRow('Jumat', '08:00 - 17:00'),
                _scheduleRow('Sabtu', '08:00 - 15:00'),
                _scheduleRow('Minggu', 'Tutup', isClosed: true),
              ],
            ),
          ),
          crossFadeState: _isOperationalExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }

  Widget _scheduleRow(String day, String time, {bool isClosed = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontSize: 13, color: AppTheme.textDark)),
          Text(
            time,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isClosed ? Colors.red : AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 4. METODE PEMBAYARAN
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildMetodePembayaran(BuildContext context) {
    return _sectionCard(
      title: 'Metode Pembayaran',
      children: [
        _paymentTile(
          'QRIS AstraPay',
          Icons.qr_code_rounded,
          AppTheme.primaryBlue,
          enabled: true,
          badge: 'AstraPay',
          onTap: () => _showQRISBengkel(context),
        ),
        const Divider(height: 1, indent: 66),
        _paymentTile(
          'Cash',
          Icons.payments_rounded,
          AppTheme.successGreen,
          enabled: true,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            _buildSnackBar('Pembayaran tunai tersedia'),
          ),
        ),
        const Divider(height: 1, indent: 66),
        _paymentTile(
          'Transfer Bank',
          Icons.account_balance_rounded,
          AppTheme.textGrey,
          enabled: false,
          subtitle: 'Segera Hadir',
        ),
      ],
    );
  }

  void _showQRISBengkel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(ctx).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFFE8EBF0), borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            const Text('QRIS Bengkel Anda', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 4),
            const Text('Tunjukkan ke pelanggan untuk menerima pembayaran', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
            const SizedBox(height: 24),
            // QRIS Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2), width: 2),
                boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 6))],
              ),
              child: Column(
                children: [
                  // QRIS header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/QRIS_logo.svg/120px-QRIS_logo.svg.png',
                        width: 60,
                        height: 24,
                        errorBuilder: (_, __, ___) => const Text('QRIS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.primaryBlue)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // QR Code
                  QrImageView(
                    data: '00020101021226670016COM.ASTRAPAY.WWW0118936000091200001230221BENGKEL-JAYAMOTOR-BDG5204541153033605802ID5917Bengkel Jaya Motor6007Bandung61054023262070503***63041B2A',
                    version: QrVersions.auto,
                    size: 200,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Color(0xFF1A1A2E),
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Bengkel Jaya Motor', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                  const SizedBox(height: 2),
                  Text('NMID: ID102300112345678', style: TextStyle(fontSize: 11, color: AppTheme.textGrey, letterSpacing: 0.5)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Info chips
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, color: AppTheme.successGreen, size: 14),
                      const SizedBox(width: 4),
                      Text('Verified Merchant', style: TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shield, color: AppTheme.primaryBlue, size: 14),
                      const SizedBox(width: 4),
                      Text('AstraPay', style: TextStyle(fontSize: 11, color: AppTheme.primaryBlue, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar('QRIS disimpan ke galeri'));
                    },
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('Simpan'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryBlue,
                      side: const BorderSide(color: AppTheme.primaryBlue),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar('QRIS dibagikan'));
                    },
                    icon: const Icon(Icons.share_rounded, size: 18),
                    label: const Text('Bagikan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile(String title, IconData icon, Color color, {
    bool enabled = true,
    String? badge,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(enabled ? 0.1 : 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: enabled ? color : AppTheme.textLight, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: enabled ? AppTheme.textDark : AppTheme.textLight,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge,
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        subtitle,
                        style: const TextStyle(fontSize: 11, color: AppTheme.textLight, fontStyle: FontStyle.italic),
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              enabled ? Icons.check_circle_rounded : Icons.schedule_rounded,
              color: enabled ? AppTheme.successGreen : AppTheme.textLight,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 5. ASTRAPAY BUSINESS SECTION
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildAstraPayBusiness(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryBlue.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AstraPay Business Account',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.verified_rounded, color: Colors.greenAccent, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Status: Verified',
                            style: TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Saldo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo Tersedia',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Rp 3.500.000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showTarikDanaSheet(context),
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('Tarik Dana', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.darkBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showSettlementHistory(context),
                    icon: const Icon(Icons.history_rounded, size: 18),
                    label: const Text('Riwayat', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 6. FITUR BISNIS
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildFiturBisnis(BuildContext context) {
    return _sectionCard(
      title: 'Fitur Bisnis',
      children: [
        _fiturTile(
          icon: Icons.monetization_on_rounded,
          color: AppTheme.primaryBlue,
          title: 'Ajukan Pinjaman Modal',
          subtitle: 'Hingga Rp 25jt, bunga 0.5%/bulan',
          onTap: () => _showPinjamanModal(context),
        ),
        const Divider(height: 1, indent: 66),
        _fiturTile(
          icon: Icons.local_offer_rounded,
          color: AppTheme.warningOrange,
          title: 'Promo & Diskon',
          subtitle: 'Atur promosi untuk pelanggan',
          onTap: () => _showPromoSheet(context),
        ),
        const Divider(height: 1, indent: 66),
        _fiturTile(
          icon: Icons.description_rounded,
          color: AppTheme.successGreen,
          title: 'Laporan Pajak',
          subtitle: 'Ringkasan pajak bulanan',
          onTap: () => _showLaporanPajakSheet(context),
        ),
      ],
    );
  }

  Widget _fiturTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textGrey),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 7. SETTINGS
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildSettings(BuildContext context) {
    return _sectionCard(
      title: 'Pengaturan',
      children: [
        _settingsTile(
          icon: Icons.notifications_rounded,
          title: 'Notifikasi',
          trailing: Switch(
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() => _notificationsEnabled = val);
              ScaffoldMessenger.of(context).showSnackBar(
                _buildSnackBar(val ? 'Notifikasi diaktifkan' : 'Notifikasi dinonaktifkan'),
              );
            },
            activeColor: AppTheme.primaryBlue,
          ),
        ),
        const Divider(height: 1, indent: 66),
        _settingsTile(
          icon: Icons.language_rounded,
          title: 'Bahasa',
          subtitle: 'Bahasa Indonesia',
          onTap: () => _showBahasaDialog(context),
        ),
        const Divider(height: 1, indent: 66),
        _settingsTile(
          icon: Icons.help_outline_rounded,
          title: 'Bantuan & FAQ',
          onTap: () => _showFaqSheet(context),
        ),
        const Divider(height: 1, indent: 66),
        _settingsTile(
          icon: Icons.article_outlined,
          title: 'Syarat & Ketentuan',
          onTap: () => _showSyaratSheet(context),
        ),
        const Divider(height: 1, indent: 66),
        _settingsTile(
          icon: Icons.logout_rounded,
          title: 'Keluar',
          titleColor: Colors.red,
          iconColor: Colors.red,
          onTap: () => _showLogoutDialog(context),
        ),
      ],
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: (iconColor ?? AppTheme.primaryBlue).withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor ?? AppTheme.primaryBlue, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: titleColor ?? AppTheme.textDark,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (onTap != null)
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textGrey),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // 8. FOOTER
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          'OtoCare by AstraPay',
          style: TextStyle(fontSize: 13, color: AppTheme.textGrey.withOpacity(0.7), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          'v1.0.0',
          style: TextStyle(fontSize: 11, color: AppTheme.textLight.withOpacity(0.7)),
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // SHARED UI COMPONENTS
  // ──────────────────────────────────────────────────────────────────────────
  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark),
              ),
            ),
            ...children,
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primaryBlue, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  SnackBar _buildSnackBar(String message) {
    return SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 13)),
      backgroundColor: AppTheme.primaryBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 2),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // MODAL / DIALOG / SHEET ACTIONS
  // ──────────────────────────────────────────────────────────────────────────

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
              Center(
                child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 20),
              const Text('Edit Profil Bisnis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildTextField('Nama Bengkel', 'Bengkel Jaya Motor'),
              const SizedBox(height: 12),
              _buildTextField('Nama Pemilik', 'Budi Santoso'),
              const SizedBox(height: 12),
              _buildTextField('Nomor Telepon', '0812-3456-7890', inputType: TextInputType.phone),
              const SizedBox(height: 12),
              _buildTextField('Email', 'jayamotor@email.com', inputType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              _buildTextField('Alamat', 'Jl. Raya Margahayu No. 15, Bandung', maxLines: 2),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      _buildSnackBar('Profil berhasil diperbarui'),
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

  void _showTarikDanaSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('Tarik Dana', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Saldo tersedia: Rp 3.500.000', style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Jumlah Penarikan',
                prefixText: 'Rp ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nomor Rekening Tujuan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    _buildSnackBar('Penarikan dana sedang diproses (1x24 jam)'),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Tarik Sekarang'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showSettlementHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('Riwayat Settlement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _settlementItem('5 Jun 2026', 'Rp 1.200.000', 'Berhasil'),
            _settlementItem('28 Mei 2026', 'Rp 2.500.000', 'Berhasil'),
            _settlementItem('21 Mei 2026', 'Rp 890.000', 'Berhasil'),
            _settlementItem('14 Mei 2026', 'Rp 1.750.000', 'Berhasil'),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Tutup'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settlementItem(String date, String amount, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check_circle_outline, color: AppTheme.successGreen, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(amount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                Text(date, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(status, style: const TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showPinjamanModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.monetization_on_rounded, color: AppTheme.primaryBlue, size: 22),
            ),
            const SizedBox(width: 12),
            const Text('Pinjaman Modal', style: TextStyle(fontSize: 17)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajukan pinjaman modal usaha melalui AstraPay Bisnis untuk mengembangkan bengkel kamu.',
              style: TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.5),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Keuntungan:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text('• Bunga rendah mulai 0.5%/bulan', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  Text('• Tenor fleksibel 3-12 bulan', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  Text('• Pencairan cepat ke saldo AstraPay', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  Text('• Tanpa jaminan hingga Rp 25jt', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Limit pinjaman: Rp 25.000.000',
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
                _buildSnackBar('Pengajuan pinjaman modal sedang diproses'),
              );
            },
            child: const Text('Ajukan Sekarang'),
          ),
        ],
      ),
    );
  }

  void _showPromoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('Promo & Diskon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Atur promosi untuk menarik lebih banyak pelanggan', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 20),
            _promoOption(ctx, 'Diskon Service Rutin', '10% untuk pelanggan baru', true),
            const SizedBox(height: 10),
            _promoOption(ctx, 'Gratis Cek Kendaraan', 'Setiap hari Sabtu', true),
            const SizedBox(height: 10),
            _promoOption(ctx, 'Cashback AstraPay', '5% untuk pembayaran QRIS', false),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    _buildSnackBar('Fitur buat promo baru segera hadir'),
                  );
                },
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Buat Promo Baru'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppTheme.primaryBlue),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _promoOption(BuildContext ctx, String title, String subtitle, bool active) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: active ? AppTheme.successGreen.withOpacity(0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: active ? AppTheme.successGreen.withOpacity(0.3) : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            active ? Icons.check_circle_rounded : Icons.pause_circle_outline_rounded,
            color: active ? AppTheme.successGreen : AppTheme.textGrey,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Text(active ? 'Aktif' : 'Nonaktif', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: active ? AppTheme.successGreen : AppTheme.textGrey)),
        ],
      ),
    );
  }

  void _showLaporanPajakSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('Laporan Pajak', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Ringkasan pajak bulan Juni 2026', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 20),
            _taxRow('Pendapatan Kotor', 'Rp 12.800.000'),
            _taxRow('PPh Final (0.5%)', 'Rp 64.000'),
            _taxRow('Status', 'Belum Dibayar'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    _buildSnackBar('Laporan pajak lengkap sedang disiapkan'),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Unduh Laporan'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _taxRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: AppTheme.textGrey)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  void _showBahasaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Pilih Bahasa', style: TextStyle(fontSize: 17)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bahasaOption(ctx, 'Bahasa Indonesia', true),
            const SizedBox(height: 8),
            _bahasaOption(ctx, 'English', false),
          ],
        ),
      ),
    );
  }

  Widget _bahasaOption(BuildContext ctx, String label, bool selected) {
    return InkWell(
      onTap: () {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(context).showSnackBar(
          _buildSnackBar('Bahasa disetel ke $label'),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryBlue.withOpacity(0.08) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? AppTheme.primaryBlue.withOpacity(0.3) : Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: TextStyle(fontSize: 14, fontWeight: selected ? FontWeight.w600 : FontWeight.w400, color: AppTheme.textDark))),
            if (selected) const Icon(Icons.check_rounded, color: AppTheme.primaryBlue, size: 20),
          ],
        ),
      ),
    );
  }

  void _showFaqSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              const Text('Bantuan & FAQ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _faqItem('Bagaimana cara menerima pembayaran QRIS?', 'Pastikan akun AstraPay Bisnis sudah terverifikasi. Pelanggan cukup scan QR Code yang ada di bengkel Anda.'),
              _faqItem('Bagaimana cara tarik dana?', 'Buka menu Profil > AstraPay Business > Tarik Dana. Dana akan masuk ke rekening terdaftar dalam 1x24 jam.'),
              _faqItem('Bagaimana cara ajukan pinjaman?', 'Buka menu Fitur Bisnis > Ajukan Pinjaman Modal. Isi formulir dan tunggu persetujuan dalam 2-3 hari kerja.'),
              _faqItem('Bagaimana mengubah jam operasional?', 'Buka menu Profil > Edit > ubah jam operasional sesuai kebutuhan Anda.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text(question, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
        children: [
          Text(answer, style: const TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.5)),
        ],
      ),
    );
  }

  void _showSyaratSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('Syarat & Ketentuan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              'Dengan menggunakan layanan OtoCare by AstraPay, Anda menyetujui seluruh syarat dan ketentuan yang berlaku termasuk penggunaan data, kebijakan privasi, dan ketentuan layanan pembayaran digital.\n\nUntuk informasi lengkap, kunjungi website resmi AstraPay atau hubungi customer service kami.',
              style: TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.6),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Tutup'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Keluar', style: TextStyle(fontSize: 17)),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari akun bisnis?',
          style: TextStyle(fontSize: 14, color: AppTheme.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                _buildSnackBar('Berhasil keluar dari akun'),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // HELPER
  // ──────────────────────────────────────────────────────────────────────────
  Widget _buildTextField(String label, String initialValue, {TextInputType? inputType, int maxLines = 1}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      controller: TextEditingController(text: initialValue),
      keyboardType: inputType,
      maxLines: maxLines,
    );
  }
}
