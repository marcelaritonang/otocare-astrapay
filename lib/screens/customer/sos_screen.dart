import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/app_theme.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> with TickerProviderStateMixin {
  int _stage = 0; // 0=initial, 1=searching, 2=found, 3=dispatched
  late AnimationController _pulseController;
  Timer? _timer;

  final List<Map<String, dynamic>> _nearbyMechanics = [
    {
      'name': 'Mekanik Andi',
      'bengkel': 'AHASS Hero Motor',
      'distance': '1.2 km',
      'eta': '5 menit',
      'rating': 4.8,
      'photo': Icons.person,
      'speciality': 'Honda Specialist',
    },
    {
      'name': 'Mekanik Budi',
      'bengkel': 'GP Motor Bandung',
      'distance': '2.1 km',
      'eta': '8 menit',
      'rating': 4.5,
      'photo': Icons.person,
      'speciality': 'All Brand',
    },
    {
      'name': 'Mekanik Rizal',
      'bengkel': 'Yamaha Bahana',
      'distance': '2.8 km',
      'eta': '12 menit',
      'rating': 4.6,
      'photo': Icons.person,
      'speciality': 'Yamaha Specialist',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startSOS() {
    setState(() => _stage = 1);
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _stage = 2);
    });
  }

  void _dispatchMechanic(Map<String, dynamic> mechanic) {
    setState(() => _stage = 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _stage == 0 ? const Color(0xFFFFF5F5) : const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: _stage == 0 ? const Color(0xFFDC2626) : AppTheme.primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _stage == 0 ? 'SOS Darurat' : _stage == 3 ? 'Bantuan Datang' : 'Mencari Bantuan',
          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _stage == 0
            ? _buildInitialState()
            : _stage == 1
                ? _buildSearchingState()
                : _stage == 2
                    ? _buildFoundState()
                    : _buildDispatchedState(),
      ),
    );
  }

  Widget _buildInitialState() {
    return Column(
      key: const ValueKey(0),
      children: [
        const Spacer(),
        // SOS Pulse Button
        Center(
          child: GestureDetector(
            onTap: _startSOS,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFDC2626).withOpacity(0.2 * (1 - _pulseController.value)),
                        blurRadius: 40 + 30 * _pulseController.value,
                        spreadRadius: 10 + 20 * _pulseController.value,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                      ),
                      boxShadow: [
                        BoxShadow(color: Color(0x44DC2626), blurRadius: 20, offset: Offset(0, 8)),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning_rounded, color: Colors.white, size: 48),
                        SizedBox(height: 8),
                        Text('SOS', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 4)),
                        Text('Tap untuk bantuan', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const Spacer(),
        // Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Text(
                'Motor Mogok di Jalan?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Tekan tombol SOS untuk memanggil mekanik terdekat. Lokasi Anda akan otomatis terdeteksi.',
                style: TextStyle(fontSize: 13, color: AppTheme.textGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Features
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _featureChip(Icons.location_on, 'Auto GPS'),
                  _featureChip(Icons.speed, 'Respon Cepat'),
                  _featureChip(Icons.shield, 'Aman'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _featureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFDC2626), size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  Widget _buildSearchingState() {
    return Center(
      key: const ValueKey(1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated radar
          SizedBox(
            width: 160, height: 160,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) => CustomPaint(
                painter: _RadarPainter(progress: _pulseController.value),
                child: const Center(
                  child: Icon(Icons.two_wheeler, color: AppTheme.primaryBlue, size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text('Mencari Mekanik Terdekat...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
          const SizedBox(height: 8),
          Text('Lokasi: Jl. Soekarno Hatta, Bandung', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
          const SizedBox(height: 24),
          SizedBox(width: 200, child: LinearProgressIndicator(
            backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
          )),
        ],
      ),
    );
  }

  Widget _buildFoundState() {
    return SingleChildScrollView(
      key: const ValueKey(2),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.successGreen.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: AppTheme.successGreen, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.check, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('3 Mekanik Ditemukan!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                      SizedBox(height: 2),
                      Text('Pilih mekanik untuk dipanggil', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Mekanik Tersedia', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          ..._nearbyMechanics.map((m) => _mechanicCard(m)),
        ],
      ),
    );
  }

  Widget _mechanicCard(Map<String, dynamic> mechanic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.engineering, color: AppTheme.primaryBlue, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mechanic['name'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    Text(mechanic['bengkel'] as String, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFF59E0B), size: 14),
                        const SizedBox(width: 3),
                        Text('${mechanic['rating']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 10),
                        Icon(Icons.location_on, color: AppTheme.textGrey, size: 13),
                        Text(' ${mechanic['distance']}', style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('ETA ${mechanic['eta']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.successGreen)),
                  ),
                  const SizedBox(height: 4),
                  Text(mechanic['speciality'] as String, style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _dispatchMechanic(mechanic),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Panggil Mekanik', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDispatchedState() {
    final mechanic = _nearbyMechanics[0];
    return SingleChildScrollView(
      key: const ValueKey(3),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Success animation
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 60),
          ),
          const SizedBox(height: 20),
          const Text('Mekanik Dalam Perjalanan!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
          const SizedBox(height: 8),
          Text('Estimasi tiba dalam ${mechanic['eta']}', style: const TextStyle(fontSize: 14, color: AppTheme.textGrey)),
          const SizedBox(height: 32),
          // Mechanic detail card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 6))],
            ),
            child: Column(
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.engineering, color: AppTheme.primaryBlue, size: 32),
                ),
                const SizedBox(height: 12),
                Text(mechanic['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                Text(mechanic['bengkel'] as String, style: const TextStyle(fontSize: 13, color: AppTheme.textGrey)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoChip(Icons.star, '${mechanic['rating']}', 'Rating'),
                    _infoChip(Icons.location_on, mechanic['distance'] as String, 'Jarak'),
                    _infoChip(Icons.timer, mechanic['eta'] as String, 'ETA'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Progress tracker
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Status Perjalanan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                const SizedBox(height: 16),
                _progressStep('Permintaan diterima', true),
                _progressStep('Mekanik berangkat', true),
                _progressStep('Dalam perjalanan', true),
                _progressStep('Tiba di lokasi', false),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Contact buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, size: 18),
                  label: const Text('Hubungi'),
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
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                  label: const Text('Chat'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryBlue,
                    side: const BorderSide(color: AppTheme.primaryBlue),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Payment info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet, color: AppTheme.primaryBlue, size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Pembayaran via AstraPay setelah selesai', style: TextStyle(fontSize: 12, color: AppTheme.textDark)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 18),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
      ],
    );
  }

  Widget _progressStep(String label, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 24, height: 24,
            decoration: BoxDecoration(
              color: done ? AppTheme.successGreen : const Color(0xFFF1F3F8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              done ? Icons.check : Icons.circle_outlined,
              color: done ? Colors.white : AppTheme.textLight,
              size: 14,
            ),
          ),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(
            fontSize: 13,
            fontWeight: done ? FontWeight.w600 : FontWeight.w400,
            color: done ? AppTheme.textDark : AppTheme.textGrey,
          )),
          if (!done) ...[
            const Spacer(),
            SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue))),
          ],
        ],
      ),
    );
  }
}

// Radar animation painter
class _RadarPainter extends CustomPainter {
  final double progress;
  _RadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 3; i++) {
      final p = (progress + i * 0.33) % 1.0;
      final radius = 30 + p * 50;
      final paint = Paint()
        ..color = AppTheme.primaryBlue.withOpacity(0.3 * (1 - p))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
