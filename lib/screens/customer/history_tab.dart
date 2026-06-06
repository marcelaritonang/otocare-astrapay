import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  final List<Map<String, dynamic>> _history = const [
    {
      'bengkel': 'Bengkel Jaya Motor',
      'date': '15 Mar 2026',
      'service': 'Ganti Oli + Tune Up',
      'cost': 'Rp 185.000',
      'status': 'completed',
      'hasReceipt': true,
    },
    {
      'bengkel': 'Mitra Motor Sejahtera',
      'date': '20 Jan 2026',
      'service': 'Ganti Kampas Rem Depan',
      'cost': 'Rp 120.000',
      'status': 'completed',
      'hasReceipt': true,
    },
    {
      'bengkel': 'Bengkel Pak Budi',
      'date': '05 Des 2025',
      'service': 'Servis Berkala 16.000km',
      'cost': 'Rp 350.000',
      'status': 'completed',
      'hasReceipt': false,
    },
    {
      'bengkel': 'Bengkel Jaya Motor',
      'date': '18 Okt 2025',
      'service': 'Ganti Oli',
      'cost': 'Rp 85.000',
      'status': 'completed',
      'hasReceipt': true,
    },
    {
      'bengkel': 'Speed Motor Workshop',
      'date': '02 Agu 2025',
      'service': 'Ganti V-Belt + Roller',
      'cost': 'Rp 280.000',
      'status': 'completed',
      'hasReceipt': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          _buildScanButton(context),
          Expanded(child: _buildHistoryList(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('History Service', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Riwayat perawatan motor kamu', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                _statItem('Total Service', '5'),
                _divider(),
                _statItem('Total Biaya', 'Rp 1.02jt'),
                _divider(),
                _statItem('Bulan Ini', '0'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10)),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 30, color: Colors.white.withOpacity(0.3));
  }

  Widget _buildScanButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () => _showOCRSheet(context),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.accentPink.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.accentPink.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppTheme.accentPink.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.camera_alt, color: AppTheme.accentPink, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scan Struk Service', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    Text('Foto struk untuk otomatis masuk history (OCR + AI)', style: TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: AppTheme.textGrey, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final item = _history[index];
        return _buildHistoryCard(context, item);
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.build, color: AppTheme.primaryBlue, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['bengkel'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                    Text(item['date'], style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
                  ],
                ),
              ),
              Text(item['cost'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(6)),
                child: Text(item['service'], style: TextStyle(fontSize: 11, color: AppTheme.primaryBlue)),
              ),
              const Spacer(),
              if (item['hasReceipt'])
                Row(
                  children: [
                    Icon(Icons.receipt_long, color: AppTheme.successGreen, size: 14),
                    const SizedBox(width: 4),
                    Text('Struk', style: TextStyle(fontSize: 11, color: AppTheme.successGreen, fontWeight: FontWeight.w500)),
                  ],
                ),
              if (!item['hasReceipt'])
                GestureDetector(
                  onTap: () => _showOCRSheet(context),
                  child: Row(
                    children: [
                      Icon(Icons.add_a_photo, color: AppTheme.warningOrange, size: 14),
                      const SizedBox(width: 4),
                      Text('Tambah Struk', style: TextStyle(fontSize: 11, color: AppTheme.warningOrange, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showOCRSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            const Text('Scan Struk Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 8),
            const Text('Foto struk bengkel, AI akan parsing otomatis', style: TextStyle(fontSize: 13, color: AppTheme.textGrey)),
            const SizedBox(height: 24),
            // Camera placeholder
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      Text('Arahkan kamera ke struk', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => _showOCRResult(ctx),
                        icon: const Icon(Icons.photo_library, size: 18),
                        label: const Text('Pilih dari Galeri'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showOCRResult(ctx),
                icon: const Icon(Icons.camera, size: 20),
                label: const Text('Ambil Foto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOCRResult(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: AppTheme.successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.auto_awesome, color: AppTheme.successGreen, size: 24),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Parsing Berhasil! ✨', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Data berhasil diekstrak dari struk', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _ocrResultRow('Bengkel', 'Bengkel Jaya Motor'),
            _ocrResultRow('Tanggal', '10 Jun 2026'),
            _ocrResultRow('Layanan', 'Ganti Oli Yamalube 1L'),
            _ocrResultRow('Sparepart', 'Oli Yamalube Gold 10W-40'),
            _ocrResultRow('Total', 'Rp 85.000'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Edit')),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Simpan ke History'),
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

  Widget _ocrResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textDark))),
        ],
      ),
    );
  }
}
