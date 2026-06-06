import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/customer/customer_main.dart';
import 'screens/umkm/umkm_main.dart';

void main() {
  runApp(const AstraPayApp());
}

class AstraPayApp extends StatelessWidget {
  const AstraPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AstraPay',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const AstraPayHome(),
    );
  }
}

class AstraPayHome extends StatefulWidget {
  const AstraPayHome({super.key});

  @override
  State<AstraPayHome> createState() => _AstraPayHomeState();
}

class _AstraPayHomeState extends State<AstraPayHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _HomeScreen(),
          _TransactionHistory(),
          SizedBox(), // QR placeholder
          _InboxScreen(),
          _ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.home_filled, 'Home'),
              _navItem(1, Icons.receipt_long, 'Transaksi'),
              _centerQR(),
              _navItem(3, Icons.mail_outline, 'Inbox'),
              _navItem(4, Icons.person_outline, 'Akun'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey, size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 10, color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _centerQR() {
    return GestureDetector(
      onTap: () => _showQRPay(),
      child: Container(
        width: 56, height: 56,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, color: Colors.white, size: 22),
            Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _showQRPay() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            Container(
              width: 200, height: 200,
              decoration: BoxDecoration(border: Border.all(color: AppTheme.primaryBlue, width: 3), borderRadius: BorderRadius.circular(16)),
              child: const Center(child: Icon(Icons.qr_code_2, size: 150, color: AppTheme.primaryBlue)),
            ),
            const SizedBox(height: 16),
            const Text('Scan & Pay', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Arahkan kamera ke QRIS merchant', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ==================== HOME SCREEN (mirip AstraPay asli) ====================
class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildSaldoCard(context),
            const SizedBox(height: 6),
            _buildQuickFeatures(),
            const SizedBox(height: 12),
            _buildReferralBanner(),
            const SizedBox(height: 16),
            _buildServicesGrid(context),
            const SizedBox(height: 16),
            _buildPromoBanner(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      color: Colors.white,
      child: Row(
        children: [
          // AstraPay logo
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(child: Text('A', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AstraPay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
              Text('Bayar Apa Aja Hemat', style: TextStyle(fontSize: 10, color: AppTheme.textGrey)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(14)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_offer, color: AppTheme.primaryBlue, size: 14),
                  const SizedBox(width: 4),
                  Text('Cek promo', style: TextStyle(fontSize: 11, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.notifications_outlined, color: AppTheme.textDark, size: 22),
        ],
      ),
    );
  }

  Widget _buildSaldoCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet, color: AppTheme.primaryBlue, size: 20),
              const SizedBox(width: 8),
              const Text('Saldo', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
              const Spacer(),
              const Icon(Icons.visibility_outlined, color: AppTheme.textGrey, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Rp', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
              const Text('5.000.000', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              const Spacer(),
              _actionBtn(Icons.add, 'Top Up', AppTheme.primaryBlue),
              const SizedBox(width: 12),
              _actionBtn(Icons.send, 'Transfer', const Color(0xFF7C4DFF)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildQuickFeatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.star, color: AppTheme.primaryBlue, size: 18),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AstraPayLater', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                      Text('Limit Rp 1.000.000', style: TextStyle(fontSize: 9, color: AppTheme.textGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.card_giftcard, color: Colors.amber, size: 18),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Voucher Saya', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                      Text('12 voucher', style: TextStyle(fontSize: 9, color: AppTheme.textGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF6B9D), Color(0xFFFF8E53)], begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.people, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ajak Teman, Dapat Bonus!', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                Text('Bagikan kode referral & dapatkan Rp 25.000', style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 10)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: const Text('Bagikan', style: TextStyle(fontSize: 11, color: Color(0xFFFF6B9D), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Layanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              Text('Lihat Semua', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 14,
            crossAxisSpacing: 8,
            childAspectRatio: 0.78,
            children: [
              _serviceItem(context, Icons.two_wheeler, 'OtoCare', AppTheme.primaryBlue, isNew: true,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OtoCareEntry()))),
              _serviceItem(context, Icons.credit_card, 'Angsuran', const Color(0xFF1E88E5)),
              _serviceItem(context, Icons.phone_android, 'Pulsa &\nPaket Data', const Color(0xFF7C4DFF)),
              _serviceItem(context, Icons.bolt, 'PLN', const Color(0xFFFFA726)),
              _serviceItem(context, Icons.account_balance, 'Uang\nElektronik', const Color(0xFF26A69A)),
              _serviceItem(context, Icons.receipt, 'Tagihan\nKartu Kredit', const Color(0xFFEF5350)),
              _serviceItem(context, Icons.card_giftcard, 'Gift\nVoucher', const Color(0xFFAB47BC)),
              _serviceItem(context, Icons.directions_bus, 'Transportasi', const Color(0xFF42A5F5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceItem(BuildContext context, IconData icon, String label, Color color, {bool isNew = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              if (isNew)
                Positioned(
                  top: -4, right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                    child: const Text('NEW', style: TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: AppTheme.textDark, height: 1.2), maxLines: 2),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Promo Untukmu', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _promoCard('Cashback 50%', 'Service pertama\nvia OtoCare', 'Maks. Rp 50.000', AppTheme.primaryBlue, Icons.two_wheeler),
                _promoCard('QRIS Hemat', 'Bayar pakai QRIS\ndi mana pun', 'Cashback 10%', const Color(0xFF00BFA5), Icons.qr_code),
                _promoCard('Top Up Bonus', 'Min. Rp 500rb\nvia bank apapun', 'Bonus Rp 25.000', const Color(0xFFFFA726), Icons.add_card),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoCard(String title, String desc, String subtext, Color color, IconData icon) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.75)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
              const SizedBox(width: 6),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          ),
          const SizedBox(height: 8),
          Text(desc, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.9), height: 1.3)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(8)),
            child: Text(subtext, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

// ==================== TRANSACTION HISTORY ====================
class _TransactionHistory extends StatelessWidget {
  const _TransactionHistory();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Riwayat Transaksi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _txItem('Service Bengkel Jaya Motor', '5 Jun 2026', '-Rp 150.000', Icons.two_wheeler),
                  _txItem('Top Up via BCA', '4 Jun 2026', '+Rp 500.000', Icons.add_circle),
                  _txItem('Transfer ke Andi', '3 Jun 2026', '-Rp 75.000', Icons.send),
                  _txItem('Pulsa Telkomsel', '2 Jun 2026', '-Rp 50.000', Icons.phone_android),
                  _txItem('Cashback OtoCare', '1 Jun 2026', '+Rp 25.000', Icons.card_giftcard),
                  _txItem('QRIS Indomaret', '30 May 2026', '-Rp 45.000', Icons.qr_code),
                  _txItem('Top Up via Mandiri', '28 May 2026', '+Rp 300.000', Icons.add_circle),
                  _txItem('PLN Prepaid', '27 May 2026', '-Rp 100.000', Icons.bolt),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _txItem(String title, String date, String amount, IconData icon) {
    final isCredit = amount.startsWith('+');
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8)]),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            Text(date, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
          ])),
          Text(amount, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isCredit ? AppTheme.successGreen : Colors.red)),
        ],
      ),
    );
  }
}

// ==================== INBOX ====================
class _InboxScreen extends StatelessWidget {
  const _InboxScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Inbox', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 16),
            _inboxItem('Promo OtoCare 🔧', 'Cashback 50% untuk service pertama via OtoCare!', '2 jam lalu', true),
            _inboxItem('Transfer Berhasil', 'Transfer Rp 75.000 ke Andi berhasil.', '5 Jun'),
            _inboxItem('Top Up Berhasil', 'Top Up Rp 500.000 via BCA berhasil.', '4 Jun'),
            _inboxItem('Selamat Bergabung!', 'Akun AstraPay Premium kamu sudah aktif.', '1 Jun'),
          ],
        ),
      ),
    );
  }

  Widget _inboxItem(String title, String desc, String time, [bool isNew = false]) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isNew ? AppTheme.primaryBlue.withOpacity(0.04) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isNew ? AppTheme.primaryBlue.withOpacity(0.2) : Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(isNew ? Icons.local_offer : Icons.mail_outline, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(title, style: TextStyle(fontSize: 13, fontWeight: isNew ? FontWeight.w600 : FontWeight.w500, color: AppTheme.textDark))),
              Text(time, style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
            ]),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey), maxLines: 2),
          ])),
        ],
      ),
    );
  }
}

// ==================== PROFILE ====================
class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(gradient: AppTheme.primaryGradient, shape: BoxShape.circle),
              child: const Icon(Icons.person, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 12),
            const Text('Marcel Aritonang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            const Text('+62 812-3456-7890', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: const Text('AstraPay Premium ✓', style: TextStyle(fontSize: 11, color: AppTheme.primaryBlue, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 24),
            _profileMenu(Icons.account_circle_outlined, 'Data Diri'),
            _profileMenu(Icons.security, 'Keamanan Akun'),
            _profileMenu(Icons.account_balance, 'Rekening Bank'),
            _profileMenu(Icons.credit_card, 'Kartu Saya'),
            _profileMenu(Icons.help_outline, 'Pusat Bantuan'),
            _profileMenu(Icons.info_outline, 'Tentang AstraPay'),
            _profileMenu(Icons.description_outlined, 'Syarat & Ketentuan'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Keluar', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileMenu(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 22),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark))),
          const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textGrey),
        ],
      ),
    );
  }
}

// ==================== OTOCARE ENTRY (Role Selector) ====================
class OtoCareEntry extends StatelessWidget {
  const OtoCareEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textDark, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            // Logo & Title
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8)),
                ],
              ),
              child: const Icon(Icons.two_wheeler, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 20),
            const Text(
              'OtoCare',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih Profil Anda',
              style: TextStyle(fontSize: 15, color: AppTheme.textGrey, fontWeight: FontWeight.w400),
            ),
            const Spacer(flex: 2),
            // Role Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _roleCard(
                    context,
                    icon: Icons.two_wheeler,
                    title: 'Pemilik Kendaraan',
                    description: 'Cari bengkel terdekat, booking service,\ndan pantau riwayat perawatan motor Anda.',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const CustomerMain()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _roleCard(
                    context,
                    icon: Icons.build_circle_outlined,
                    title: 'Pemilik Bengkel',
                    description: 'Kelola pesanan masuk, atur jadwal,\ndan kembangkan bisnis bengkel UMKM Anda.',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const UmkmMain()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(BuildContext context, {required IconData icon, required String title, required String description, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryBlue.withOpacity(0.1), AppTheme.primaryBlue.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppTheme.primaryBlue, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey, height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textGrey),
          ],
        ),
      ),
    );
  }
}
