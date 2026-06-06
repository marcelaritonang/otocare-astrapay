import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/app_theme.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isThinking = false;
  int _questionIndex = 0;

  final List<Map<String, String>> _suggestions = [
    {'q': 'Kapan harus ganti oli?', 'icon': '🛢️'},
    {'q': 'Estimasi biaya setahun?', 'icon': '💰'},
    {'q': 'Tips hemat maintenance?', 'icon': '💡'},
    {'q': 'Kenapa motor brebet?', 'icon': '🔧'},
  ];

  final Map<String, String> _aiResponses = {
    'kapan harus ganti oli': '''Berdasarkan data motor kamu:
🏍️ Honda Vario 160 (2024)
📅 Terakhir ganti oli: 15 Mar 2026
📏 Jarak tempuh: 5.200 km sejak terakhir

⚠️ **Rekomendasi:** Segera ganti oli!
Batas aman adalah 4.000-5.000 km atau 3 bulan. Motor kamu sudah melewati keduanya.

💡 **Tips:** Gunakan oli Yamalube Gold 10W-40 untuk performa optimal Vario 160. Harga rata-rata Rp 65.000-85.000 di bengkel partner OtoCare.''',

    'estimasi biaya setahun': '''📊 **Estimasi Biaya Maintenance 2026**

Berdasarkan riwayat service kamu:

| Komponen | Frekuensi | Biaya |
|----------|-----------|-------|
| Ganti Oli | 4x/tahun | Rp 340.000 |
| Kampas Rem | 2x/tahun | Rp 240.000 |
| Busi | 2x/tahun | Rp 80.000 |
| V-Belt | 1x/tahun | Rp 250.000 |
| Filter Udara | 2x/tahun | Rp 60.000 |
| Tune Up | 4x/tahun | Rp 200.000 |

💰 **Total estimasi: Rp 1.170.000/tahun**

Tips hemat: Booking via OtoCare dan bayar pakai AstraPay bisa hemat hingga 15% (Rp 175.000/tahun)!''',

    'tips hemat maintenance': '''💡 **5 Tips Hemat Maintenance Motor**

1️⃣ **Service tepat waktu** — Telat service bikin komponen lain rusak. Ganti oli telat = piston aus lebih cepat (biaya 10x lipat!)

2️⃣ **Pakai oli yang tepat** — Vario 160 butuh 10W-40 synthetic. Jangan pakai yang terlalu murah.

3️⃣ **Cek tekanan ban tiap 2 minggu** — Ban kempes 20% = boros BBM 10% + kampas cepat habis.

4️⃣ **Booking via OtoCare** — Cashback AstraPay 15% + poin rewards yang bisa ditukar service gratis.

5️⃣ **Hindari bengkel abal-abal** — Mending bayar sedikit lebih mahal di bengkel terpercaya daripada motor rusak parah.

🔥 Kalau semua diterapkan, kamu bisa hemat Rp 300.000+/tahun!''',

    'kenapa motor brebet': '''🔍 **Diagnosis: Motor Brebet/Tersendat**

Berdasarkan profil Honda Vario 160 kamu, kemungkinan penyebab:

1️⃣ **Busi kotor/aus** (Kemungkinan 70%)
   - Busi terakhir ganti: Des 2025 (6 bulan lalu)
   - ✅ Sudah waktunya ganti!

2️⃣ **Injektor tersumbat** (Kemungkinan 40%)
   - Gejala: brebet saat RPM rendah
   - Solusi: Injector cleaner (Rp 35.000)

3️⃣ **Filter udara kotor** (Kemungkinan 60%)
   - Terakhir ganti: Agu 2025 (10 bulan!)
   - ⚠️ Sudah overdue!

🏥 **Rekomendasi:** Booking ke AHASS Hero Motor (1.2 km, rating 4.8). Biaya estimasi Rp 120.000-180.000.

Mau saya booking-kan sekarang?''',
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': 'Halo Marcel! 👋 Saya asisten AI OtoCare. Saya bisa bantu analisis kondisi motor, prediksi service, dan tips perawatan. Tanya apa saja!',
            'isAI': true,
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _sendQuestion(String question) {
    setState(() {
      _messages.add({'text': question, 'isAI': false});
      _isThinking = true;
    });
    _scrollToBottom();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      String response = 'Berdasarkan data motor kamu, saya merekomendasikan untuk membawa motor ke bengkel terdekat untuk pengecekan. Gunakan fitur "Cari Bengkel" untuk menemukan bengkel terpercaya di sekitarmu.';

      for (final entry in _aiResponses.entries) {
        if (question.toLowerCase().contains(entry.key)) {
          response = entry.value;
          break;
        }
      }

      setState(() {
        _isThinking = false;
        _messages.add({'text': response, 'isAI': true});
        _questionIndex++;
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
        title: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('OtoCare AI', style: TextStyle(color: AppTheme.textDark, fontSize: 15, fontWeight: FontWeight.w700)),
                Text('Smart Assistant', style: TextStyle(color: AppTheme.textGrey, fontSize: 11)),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: AppTheme.successGreen, size: 8),
                SizedBox(width: 4),
                Text('Online', style: TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Vehicle context card
          _buildVehicleContext(),
          Expanded(child: _buildMessages()),
          if (_isThinking) _buildThinkingIndicator(),
          _buildSuggestions(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildVehicleContext() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.two_wheeler, color: AppTheme.primaryBlue, size: 18),
          const SizedBox(width: 8),
          const Text('Honda Vario 160', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(width: 6),
          Text('• D 1234 ABC', style: TextStyle(fontSize: 11, color: AppTheme.textGrey)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('Skor: 72%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFF59E0B))),
          ),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        final isAI = msg['isAI'] as bool;
        return _buildBubble(msg['text'] as String, isAI);
      },
    );
  }

  Widget _buildBubble(String text, bool isAI) {
    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isAI ? Colors.white : AppTheme.primaryBlue,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isAI ? 4 : 16),
            bottomRight: Radius.circular(isAI ? 16 : 4),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isAI) ...[
              Row(
                children: [
                  Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                  ),
                  const SizedBox(width: 6),
                  const Text('OtoCare AI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primaryBlue)),
                ],
              ),
              const SizedBox(height: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: isAI ? AppTheme.textDark : Colors.white,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThinkingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16, height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
              ),
            ),
            const SizedBox(width: 10),
            const Text('Menganalisis data motor...', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_messages.length <= 2)
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 6),
              child: Text('Tanya sesuatu:', style: TextStyle(fontSize: 11, color: AppTheme.textGrey)),
            ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestions.map((s) => GestureDetector(
              onTap: () => _sendQuestion(s['q']!),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(s['icon']!, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(s['q']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.primaryBlue)),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
