import 'package:flutter/material.dart';
import 'dart:math';
import '../../theme/app_theme.dart';

class HealthScoreScreen extends StatelessWidget {
  const HealthScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Kesehatan Motor', style: TextStyle(color: AppTheme.textDark, fontSize: 17, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildScoreGauge(),
            const SizedBox(height: 24),
            _buildAIRecommendation(),
            const SizedBox(height: 20),
            _buildComponentList(),
            const SizedBox(height: 20),
            _buildMaintenanceForecast(),
            const SizedBox(height: 20),
            _buildActionButton(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreGauge() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          const Text('Honda Vario 160', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
          const SizedBox(height: 4),
          const Text('D 1234 ABC', style: TextStyle(fontSize: 11, color: AppTheme.textLight)),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 200,
            child: CustomPaint(
              painter: _HealthGaugePainter(score: 72),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('72', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                    Text('dari 100', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    SizedBox(height: 4),
                    Text('⚠️ Perlu Perhatian', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFF59E0B))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _legendItem(const Color(0xFFEF4444), 'Kritis'),
              _legendItem(const Color(0xFFF59E0B), 'Perhatian'),
              _legendItem(const Color(0xFF10B981), 'Baik'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
      ],
    );
  }

  Widget _buildAIRecommendation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryBlue.withOpacity(0.05), AppTheme.primaryBlue.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.info_outline, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Peringatan Service', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.primaryBlue)),
                SizedBox(height: 4),
                Text(
                  'Segera ganti oli mesin. Motor Anda sudah melewati batas 5.000 km sejak penggantian terakhir.',
                  style: TextStyle(fontSize: 12, color: AppTheme.textDark, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentList() {
    final components = [
      {'name': 'Oli Mesin', 'score': 35, 'status': 'Kritis', 'icon': Icons.oil_barrel, 'detail': 'Terakhir: 15 Mar 2026 · 5.200 km lalu'},
      {'name': 'Kampas Rem', 'score': 70, 'status': 'Cukup', 'icon': Icons.disc_full, 'detail': 'Terakhir: 20 Jan 2026 · 8.000 km lalu'},
      {'name': 'Ban', 'score': 85, 'status': 'Baik', 'icon': Icons.tire_repair, 'detail': 'Kondisi alur ban masih 70%'},
      {'name': 'Busi', 'score': 45, 'status': 'Perhatian', 'icon': Icons.electric_bolt, 'detail': 'Terakhir: 05 Des 2025 · 12.000 km lalu'},
      {'name': 'V-Belt', 'score': 90, 'status': 'Baik', 'icon': Icons.settings, 'detail': 'Terakhir: 02 Agu 2025 · masih dalam batas'},
      {'name': 'Filter Udara', 'score': 55, 'status': 'Perhatian', 'icon': Icons.air, 'detail': 'Terakhir: 02 Agu 2025 · perlu cek'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Detail Komponen', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          ...components.map((c) => _componentCard(c)),
        ],
      ),
    );
  }

  Widget _componentCard(Map<String, dynamic> component) {
    final score = component['score'] as int;
    final color = score < 40 ? const Color(0xFFEF4444) : score < 60 ? const Color(0xFFF59E0B) : const Color(0xFF10B981);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(component['icon'] as IconData, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(component['name'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text('${score}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(component['detail'] as String, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                const SizedBox(height: 8),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: score / 100,
                    backgroundColor: const Color(0xFFF1F3F8),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceForecast() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_month_rounded, color: AppTheme.primaryBlue, size: 18),
              SizedBox(width: 8),
              Text('Prediksi Maintenance', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            ],
          ),
          const SizedBox(height: 14),
          _forecastRow('Ganti Oli', '5 hari lagi', const Color(0xFFEF4444)),
          _forecastRow('Cek Busi', '2 minggu lagi', const Color(0xFFF59E0B)),
          _forecastRow('Filter Udara', '1 bulan lagi', const Color(0xFFF59E0B)),
          _forecastRow('Kampas Rem', '2 bulan lagi', const Color(0xFF10B981)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.monetization_on_rounded, color: AppTheme.warningOrange, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Estimasi biaya 3 bulan: Rp 450.000', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _forecastRow(String name, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 13, color: AppTheme.textDark))),
          Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.build_rounded, size: 20),
              SizedBox(width: 8),
              Text('Booking Service Sekarang', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for circular gauge
class _HealthGaugePainter extends CustomPainter {
  final int score;
  _HealthGaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 16;

    // Background arc
    final bgPaint = Paint()
      ..color = const Color(0xFFF1F3F8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.75 * pi,
      1.5 * pi,
      false,
      bgPaint,
    );

    // Score arc with gradient
    final scoreAngle = (score / 100) * 1.5 * pi;
    final colors = score < 40
        ? [const Color(0xFFEF4444), const Color(0xFFF87171)]
        : score < 70
            ? [const Color(0xFFF59E0B), const Color(0xFFFBBF24)]
            : [const Color(0xFF10B981), const Color(0xFF34D399)];

    final scorePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0.75 * pi,
        endAngle: 0.75 * pi + scoreAngle,
        colors: colors,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.75 * pi,
      scoreAngle,
      false,
      scorePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
