import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RatingTab extends StatelessWidget {
  const RatingTab({super.key});

  final List<Map<String, dynamic>> _reviews = const [
    {
      'name': 'Andi Pratama',
      'rating': 5,
      'date': '10 Jun 2026',
      'comment': 'Service cepat dan rapi. Mekanik ramah dan jujur soal harga. Sangat recommended!',
      'service': 'Ganti Oli + Tune Up',
    },
    {
      'name': 'Ratna Dewi',
      'rating': 5,
      'date': '8 Jun 2026',
      'comment': 'Bengkel bersih, mekanik sabar menjelaskan kerusakan. Harga sesuai estimasi di app.',
      'service': 'Servis Berkala',
    },
    {
      'name': 'Budi Santoso',
      'rating': 4,
      'date': '5 Jun 2026',
      'comment': 'Bagus overall, cuma agak lama nunggu antrian. Tapi kualitas kerja oke.',
      'service': 'Ganti Kampas Rem',
    },
    {
      'name': 'Dewi Lestari',
      'rating': 5,
      'date': '2 Jun 2026',
      'comment': 'Pertama kali service di sini, langsung jadi langganan. Top!',
      'service': 'CVT + Roller',
    },
    {
      'name': 'Reza Mahendra',
      'rating': 4,
      'date': '28 Mei 2026',
      'comment': 'Harga fair dan transparan. Booking lewat app gampang banget.',
      'service': 'Ganti Oli',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          _buildOverview(),
          Expanded(child: _buildReviewList()),
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
          const Text('Rating & Ulasan', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Feedback dari pelanggan kamu', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Row(
          children: [
            Column(
              children: [
                const Text('4.8', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                Row(
                  children: List.generate(5, (i) => Icon(
                    i < 4 ? Icons.star : Icons.star_half,
                    color: Colors.amber, size: 18,
                  )),
                ),
                const SizedBox(height: 4),
                const Text('234 ulasan', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                children: [
                  _ratingBar(5, 0.80),
                  _ratingBar(4, 0.15),
                  _ratingBar(3, 0.03),
                  _ratingBar(2, 0.01),
                  _ratingBar(1, 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(int star, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$star', style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 12),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            child: Text('${(percentage * 100).toInt()}%', style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        final review = _reviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        review['name'].toString().substring(0, 1),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                        Text(review['date'], style: const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(review['rating'] as int, (i) => const Icon(Icons.star, color: Colors.amber, size: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(review['comment'], style: const TextStyle(fontSize: 12, color: AppTheme.textDark, height: 1.4)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.06), borderRadius: BorderRadius.circular(6)),
                child: Text(review['service'], style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue)),
              ),
            ],
          ),
        );
      },
    );
  }
}
