import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../theme/app_theme.dart';

class IncomeTab extends StatefulWidget {
  const IncomeTab({super.key});

  @override
  State<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends State<IncomeTab> {
  String _selectedMonth = 'Juni 2025';
  int? _tappedBarIndex;

  final List<String> _months = [
    'April 2025',
    'Mei 2025',
    'Juni 2025',
    'Juli 2025',
  ];

  final List<Map<String, dynamic>> _weeklyData = const [
    {'week': 'Minggu 1', 'income': 1100000, 'expense': 280000},
    {'week': 'Minggu 2', 'income': 1400000, 'expense': 350000},
    {'week': 'Minggu 3', 'income': 950000, 'expense': 320000},
    {'week': 'Minggu 4', 'income': 1400000, 'expense': 300000},
  ];

  final List<Map<String, dynamic>> _topServices = const [
    {'name': 'Ganti Oli', 'revenue': 1200000, 'count': 16},
    {'name': 'Tune Up', 'revenue': 950000, 'count': 8},
    {'name': 'Service Berkala', 'revenue': 850000, 'count': 6},
    {'name': 'Ganti Kampas Rem', 'revenue': 720000, 'count': 6},
    {'name': 'Ganti V-Belt', 'revenue': 630000, 'count': 4},
  ];

  final List<Map<String, dynamic>> _transactions = const [
    {
      'service': 'Service Berkala',
      'customer': 'Andi Pratama',
      'amount': 150000,
      'type': 'income',
      'date': '10 Jun 2025',
      'time': '14:30',
      'method': 'QRIS',
      'status': 'completed',
      'icon': Icons.build_circle_outlined,
    },
    {
      'service': 'Ganti Oli',
      'customer': 'Budi Santoso',
      'amount': 75000,
      'type': 'income',
      'date': '10 Jun 2025',
      'time': '11:15',
      'method': 'Cash',
      'status': 'completed',
      'icon': Icons.oil_barrel_outlined,
    },
    {
      'service': 'Beli Sparepart',
      'customer': 'Supplier ABC',
      'amount': 450000,
      'type': 'expense',
      'date': '10 Jun 2025',
      'time': '09:00',
      'method': 'Transfer',
      'status': 'completed',
      'icon': Icons.shopping_cart_outlined,
    },
    {
      'service': 'Tune Up',
      'customer': 'Charlie Wijaya',
      'amount': 250000,
      'type': 'income',
      'date': '9 Jun 2025',
      'time': '16:45',
      'method': 'QRIS',
      'status': 'completed',
      'icon': Icons.settings_outlined,
    },
    {
      'service': 'Ganti Kampas Rem',
      'customer': 'Dewi Lestari',
      'amount': 120000,
      'type': 'income',
      'date': '9 Jun 2025',
      'time': '13:20',
      'method': 'QRIS',
      'status': 'pending',
      'icon': Icons.disc_full_outlined,
    },
    {
      'service': 'Ganti V-Belt',
      'customer': 'Eka Putra',
      'amount': 280000,
      'type': 'income',
      'date': '8 Jun 2025',
      'time': '10:00',
      'method': 'Cash',
      'status': 'completed',
      'icon': Icons.loop_outlined,
    },
    {
      'service': 'Bayar Listrik',
      'customer': 'PLN',
      'amount': 350000,
      'type': 'expense',
      'date': '8 Jun 2025',
      'time': '08:30',
      'method': 'Transfer',
      'status': 'completed',
      'icon': Icons.electrical_services_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCards(),
                  const SizedBox(height: 16),
                  _buildProfitCard(),
                  const SizedBox(height: 20),
                  _buildWeeklyChart(),
                  const SizedBox(height: 20),
                  _buildPaymentMethodBreakdown(),
                  const SizedBox(height: 20),
                  _buildTopServices(),
                  const SizedBox(height: 20),
                  _buildRecentTransactions(),
                  const SizedBox(height: 20),
                  _buildExportButton(),
                  const SizedBox(height: 24),
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Laporan Keuangan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ringkasan performa bengkel',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                    isDense: true,
                    dropdownColor: AppTheme.darkBlue,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    items: _months.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month));
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _selectedMonth = value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(child: _buildSummaryCard(
          title: 'Pendapatan',
          amount: 'Rp 4.850.000',
          change: '+12%',
          isPositive: true,
          icon: Icons.trending_up_rounded,
          color: AppTheme.successGreen,
        )),
        const SizedBox(width: 12),
        Expanded(child: _buildSummaryCard(
          title: 'Pengeluaran',
          amount: 'Rp 1.250.000',
          change: '-5%',
          isPositive: false,
          icon: Icons.trending_down_rounded,
          color: const Color(0xFFEF4444),
        )),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
    required String change,
    required bool isPositive,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$change dari bulan lalu',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfitCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.successGreen,
            AppTheme.successGreen.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.successGreen.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Laba Bersih',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Rp 3.600.000',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Margin: 74.2%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    final maxIncome = _weeklyData.map((d) => d['income'] as int).reduce(math.max);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pendapatan vs Pengeluaran',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              Row(
                children: [
                  _buildLegendDot(AppTheme.primaryBlue, 'Income'),
                  const SizedBox(width: 12),
                  _buildLegendDot(const Color(0xFFEF4444), 'Expense'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(_weeklyData.length, (index) {
                final data = _weeklyData[index];
                final income = data['income'] as int;
                final expense = data['expense'] as int;
                final incomeHeight = (income / maxIncome) * 130;
                final expenseHeight = (expense / maxIncome) * 130;
                final isTapped = _tappedBarIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _tappedBarIndex = _tappedBarIndex == index ? null : index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isTapped) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.textDark,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _formatCurrency(income),
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          if (!isTapped) const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 16,
                                height: incomeHeight,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppTheme.primaryBlue,
                                      AppTheme.primaryBlue.withOpacity(0.6),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Container(
                                width: 16,
                                height: expenseHeight,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0xFFEF4444),
                                      const Color(0xFFEF4444).withOpacity(0.6),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Mg ${index + 1}',
                            style: TextStyle(
                              fontSize: 11,
                              color: isTapped ? AppTheme.primaryBlue : AppTheme.textGrey,
                              fontWeight: isTapped ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
      ],
    );
  }

  Widget _buildPaymentMethodBreakdown() {
    final methods = [
      {'name': 'QRIS AstraPay', 'percentage': 0.65, 'amount': 'Rp 3.15jt', 'color': AppTheme.primaryBlue},
      {'name': 'Cash', 'percentage': 0.30, 'amount': 'Rp 1.45jt', 'color': AppTheme.successGreen},
      {'name': 'Transfer', 'percentage': 0.05, 'amount': 'Rp 250rb', 'color': AppTheme.warningOrange},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metode Pembayaran',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: _DonutChartPainter(methods),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 9, color: AppTheme.textGrey),
                        ),
                        Text(
                          '4.85jt',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: methods.map((method) {
                    final percentage = ((method['percentage'] as double) * 100).toInt();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: method['color'] as Color,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                Text(
                                  method['amount'] as String,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppTheme.textGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: (method['color'] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$percentage%',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: method['color'] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopServices() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Layanan Terlaris',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                'by Revenue',
                style: TextStyle(fontSize: 11, color: AppTheme.textGrey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(_topServices.length, (index) {
            final service = _topServices[index];
            final revenue = service['revenue'] as int;
            final maxRevenue = _topServices[0]['revenue'] as int;
            final barWidth = revenue / maxRevenue;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: index < 3 ? AppTheme.primaryBlue : AppTheme.textGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              service['name'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textDark,
                              ),
                            ),
                            Text(
                              _formatCurrency(revenue),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: barWidth,
                            backgroundColor: Colors.grey.shade100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              index == 0
                                  ? AppTheme.primaryBlue
                                  : index == 1
                                      ? AppTheme.lightBlue
                                      : AppTheme.primaryBlue.withOpacity(0.4),
                            ),
                            minHeight: 5,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${service['count']} transaksi',
                          style: const TextStyle(fontSize: 10, color: AppTheme.textGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi Terakhir',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                'Lihat Semua',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
        ),
        ...List.generate(_transactions.length, (index) {
          final tx = _transactions[index];
          final isIncome = tx['type'] == 'income';
          final isPending = tx['status'] == 'pending';
          final amount = tx['amount'] as int;

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: isPending ? Border.all(color: AppTheme.warningOrange.withOpacity(0.3)) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isIncome
                        ? AppTheme.successGreen.withOpacity(0.1)
                        : const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    tx['icon'] as IconData,
                    color: isIncome ? AppTheme.successGreen : const Color(0xFFEF4444),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx['service'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tx['customer'] as String,
                        style: const TextStyle(fontSize: 11, color: AppTheme.textGrey),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '${tx['date']} - ${tx['time']}',
                            style: const TextStyle(fontSize: 10, color: AppTheme.textLight),
                          ),
                          const SizedBox(width: 8),
                          _buildMethodBadge(tx['method'] as String),
                          if (isPending) ...[
                            const SizedBox(width: 6),
                            _buildStatusBadge(),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isIncome ? '+' : '-'} ${_formatCurrency(amount)}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isIncome ? AppTheme.successGreen : const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMethodBadge(String method) {
    Color badgeColor;
    switch (method) {
      case 'QRIS':
        badgeColor = AppTheme.primaryBlue;
        break;
      case 'Cash':
        badgeColor = AppTheme.successGreen;
        break;
      case 'Transfer':
        badgeColor = AppTheme.warningOrange;
        break;
      default:
        badgeColor = AppTheme.textGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: badgeColor.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        method,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: badgeColor,
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.warningOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, size: 8, color: AppTheme.warningOrange),
          SizedBox(width: 3),
          Text(
            'Pending',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppTheme.warningOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 18),
                  SizedBox(width: 10),
                  Text('Laporan dikirim ke email terdaftar'),
                ],
              ),
              backgroundColor: AppTheme.successGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(16),
            ),
          );
        },
        icon: const Icon(Icons.download_rounded, size: 20),
        label: const Text(
          'Download Laporan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 2,
          shadowColor: AppTheme.primaryBlue.withOpacity(0.3),
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    if (amount >= 1000000) {
      final value = amount / 1000000;
      return 'Rp ${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}jt';
    } else if (amount >= 1000) {
      final value = amount / 1000;
      if (amount % 1000 == 0) {
        return 'Rp ${value.toInt()}rb';
      }
      return 'Rp ${value.toStringAsFixed(0)}rb';
    }
    return 'Rp $amount';
  }
}

class _DonutChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  _DonutChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const strokeWidth = 14.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    double startAngle = -math.pi / 2;

    for (final item in data) {
      final sweepAngle = 2 * math.pi * (item['percentage'] as double);
      final paint = Paint()
        ..color = item['color'] as Color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, startAngle, sweepAngle - 0.05, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
