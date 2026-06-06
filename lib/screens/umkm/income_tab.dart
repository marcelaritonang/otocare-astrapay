import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({super.key});

  final List<Map<String, dynamic>> _transactions = const [
    {'service': 'Service Berkala', 'customer': 'Andi', 'amount': 'Rp 150.000', 'date': '10 Jun', 'method': 'QRIS'},
    {'service': 'Ganti Oli', 'customer': 'Budi', 'amount': 'Rp 75.000', 'date': '10 Jun', 'method': 'Cash'},
    {'service': 'Tune Up', 'customer': 'Charlie', 'amount': 'Rp 250.000', 'date': '9 Jun', 'method': 'QRIS'},
    {'service': 'Ganti Kampas Rem', 'customer': 'Dewi', 'amount': 'Rp 120.000', 'date': '9 Jun', 'method': 'QRIS'},
    {'service': 'Ganti V-Belt', 'customer': 'Eka', 'amount': 'Rp 280.000', 'date': '8 Jun', 'method': 'Cash'},
    {'service': 'Ganti Busi', 'customer': 'Fajar', 'amount': 'Rp 45.000', 'date': '8 Jun', 'method': 'QRIS'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIncomeSummaryCard(),
                  const SizedBox(height: 16),
                  _buildIncomeChart(),
                  const SizedBox(height: 16),
                  _buildPaymentBreakdown(),
                  const SizedBox(height: 16),
                  _buildTransactionList(),
                ],
              ),
            ),
          ),
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
          const Text('Pendapatan Bengkel', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Ringkasan keuangan bulan ini', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildIncomeSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pendapatan Bulan Ini', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
          const SizedBox(height: 8),
          const Text(
            'Rp 4.850.000',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up, color: AppTheme.successGreen, size: 16),
                const SizedBox(width: 4),
                const Text(
                  '+12% dari bulan lalu',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.successGreen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Grafik Pendapatan Mingguan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar('Mg 1', 0.6, 'Rp 1.1jt'),
                _buildBar('Mg 2', 0.8, 'Rp 1.4jt'),
                _buildBar('Mg 3', 0.5, 'Rp 950rb'),
                _buildBar('Mg 4', 1.0, 'Rp 1.4jt'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double heightFraction, String amount) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(amount, style: const TextStyle(fontSize: 9, color: AppTheme.textGrey, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Container(
              height: 100 * heightFraction,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppTheme.primaryBlue, AppTheme.primaryBlue.withOpacity(0.6)],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Metode Pembayaran', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 14),
          _buildPaymentRow('QRIS AstraPay', 0.65, '65%', AppTheme.primaryBlue),
          const SizedBox(height: 10),
          _buildPaymentRow('Cash', 0.35, '35%', AppTheme.successGreen),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, double progress, String percentage, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(percentage, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }

  Widget _buildTransactionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Transaksi Terakhir', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 12),
        ...List.generate(_transactions.length, (index) {
          final tx = _transactions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
            ),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_downward, color: AppTheme.successGreen, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tx['service']} - ${tx['customer']}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textDark),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(tx['date'], style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: tx['method'] == 'QRIS'
                                  ? AppTheme.primaryBlue.withOpacity(0.1)
                                  : AppTheme.successGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tx['method'],
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: tx['method'] == 'QRIS' ? AppTheme.primaryBlue : AppTheme.successGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  tx['amount'],
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.successGreen),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
