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
      backgroundColor: const Color(0xFFF5F7FA),
      body: _currentIndex == 0
          ? const _HomeScreen()
          : _currentIndex == 1
              ? const _TransactionHistory()
              : _currentIndex == 3
                  ? const _InboxScreen()
                  : const _ProfileScreen(),
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
              _navItem(1, Icons.receipt_long, 'History'),
              _centerQR(),
              _navItem(3, Icons.mail_outline, 'Inbox'),
              _navItem(4, Icons.person_outline, 'Profile'),
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
          Text(label, style: TextStyle(fontSize: 11, color: isActive ? AppTheme.primaryBlue : AppTheme.textGrey, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400)),
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
            Icon(Icons.qr_code_scanner, color: Colors.white, size: 24),
            Text('Pay', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600)),
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

// ==================== HOME SCREEN ====================
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
            const SizedBox(height: 16),
            _buildBalanceCard(context),
            const SizedBox(height: 20),
            _buildQuickActions(context),
            const SizedBox(height: 20),
            _buildServices(context),
            const SizedBox(height: 20),
            _buildPromoBanner(),
            const SizedBox(height: 20),
            _buildRecentTransactions(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selamat Pagi 👋', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                const Text('Marcel Aritonang', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saldo AstraPay', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    const SizedBox(height: 4),
                    const Text('Rp 1.250.000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, color: AppTheme.successGreen, size: 14),
                      const SizedBox(width: 4),
                      Text('Premium', style: TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _balanceAction(Icons.add_circle_outline, 'Top Up', context),
                _balanceAction(Icons.send, 'Transfer', context),
                _balanceAction(Icons.account_balance_wallet_outlined, 'Withdraw', context),
                _balanceAction(Icons.history, 'Mutasi', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceAction(IconData icon, String label, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 22),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _quickBtn(Icons.qr_code, 'Bayar', AppTheme.primaryBlue)),
          const SizedBox(width: 10),
          Expanded(child: _quickBtn(Icons.qr_code_scanner, 'Scan QR', const Color(0xFF7C4DFF))),
          const SizedBox(width: 10),
          Expanded(child: _quickBtn(Icons.send_rounded, 'Transfer', const Color(0xFF00BFA5))),
          const SizedBox(width: 10),
          Expanded(child: _quickBtn(Icons.add_card, 'Top Up', const Color(0xFFFFA726))),
        ],
      ),
    );
  }

  Widget _quickBtn(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Layanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
            children: [
              _serviceItem(context, Icons.two_wheeler, 'OtoCare', AppTheme.primaryBlue, isOtoCare: true),
              _serviceItem(context, Icons.phone_android, 'Pulsa', const Color(0xFF7C4DFF)),
              _serviceItem(context, Icons.bolt, 'PLN', const Color(0xFFFFA726)),
              _serviceItem(context, Icons.water_drop, 'PDAM', const Color(0xFF29B6F6)),
              _serviceItem(context, Icons.health_and_safety, 'BPJS', const Color(0xFF66BB6A)),
              _serviceItem(context, Icons.wifi, 'Internet', const Color(0xFFEC407A)),
              _serviceItem(context, Icons.games, 'Game', const Color(0xFFAB47BC)),
              _serviceItem(context, Icons.more_horiz, 'Lainnya', AppTheme.textGrey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceItem(BuildContext context, IconData icon, String label, Color color, {bool isOtoCare = false}) {
    return GestureDetector(
      onTap: isOtoCare
          ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OtoCareRoleSelector()))
          : null,
      child: Column(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: isOtoCare ? Border.all(color: color.withOpacity(0.3), width: 1.5) : null,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: AppTheme.textDark, fontWeight: isOtoCare ? FontWeight.w600 : FontWeight.w400)),
          if (isOtoCare)
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(4)),
              child: const Text('NEW', style: TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.w700)),
            ),
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
          const Text('Promo Spesial', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _promoCard('Cashback 50%', 'Service pertama via OtoCare\nMaks. Rp 50.000', AppTheme.primaryBlue),
                _promoCard('Gratis Transfer', 'Sesama AstraPay\nSampai 30 Juni', const Color(0xFF00BFA5)),
                _promoCard('Top Up Bonus', 'Min. Rp 500rb\nBonus Rp 25.000', const Color(0xFFFFA726)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _promoCard(String title, String desc, Color color) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 6),
          Text(desc, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.9), height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Transaksi Terakhir', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              Text('Lihat Semua', style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          _transactionItem(Icons.two_wheeler, 'Service Bengkel Jaya Motor', '5 Jun 2026', '-Rp 150.000', Colors.red),
          _transactionItem(Icons.add_circle, 'Top Up via BCA', '4 Jun 2026', '+Rp 500.000', AppTheme.successGreen),
          _transactionItem(Icons.send, 'Transfer ke Andi', '3 Jun 2026', '-Rp 75.000', Colors.red),
          _transactionItem(Icons.phone_android, 'Pulsa Telkomsel', '2 Jun 2026', '-Rp 50.000', Colors.red),
        ],
      ),
    );
  }

  Widget _transactionItem(IconData icon, String title, String date, String amount, Color amountColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
                Text(date, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: amountColor)),
        ],
      ),
    );
  }
}

// ==================== OTOCARE ROLE SELECTOR ====================
class OtoCareRoleSelector extends StatelessWidget {
  const OtoCareRoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text('OtoCare', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                          child: const Icon(Icons.two_wheeler, color: Colors.white, size: 44),
                        ),
                        const SizedBox(height: 16),
                        const Text('OtoCare', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('by AstraPay', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                        const SizedBox(height: 8),
                        Text(
                          'Platform bengkel UMKM digital\nterhubung langsung dengan AstraPay',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 40),
                        _roleButton(context, icon: Icons.person, title: 'Pemilik Motor', subtitle: 'Cari bengkel, booking, history service',
                          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CustomerMain()))),
                        const SizedBox(height: 16),
                        _roleButton(context, icon: Icons.store, title: 'Bengkel UMKM', subtitle: 'Kelola booking, profil, katalog',
                          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UmkmMain()))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleButton(BuildContext context, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: AppTheme.primaryBlue, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppTheme.textGrey, size: 16),
          ],
        ),
      ),
    );
  }
}

// ==================== PLACEHOLDER SCREENS ====================
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]),
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
        border: isNew ? Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
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
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 12),
            const Text('Marcel Aritonang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            const Text('marcel@email.com', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]),
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
