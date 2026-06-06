import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RatingTab extends StatefulWidget {
  const RatingTab({super.key});

  @override
  State<RatingTab> createState() => _RatingTabState();
}

class _RatingTabState extends State<RatingTab> with TickerProviderStateMixin {
  String _selectedFilter = 'Semua';
  final Map<int, bool> _replyExpanded = {};
  final Map<int, TextEditingController> _replyControllers = {};
  final Map<int, String?> _submittedReplies = {};

  late AnimationController _barAnimationController;
  late Animation<double> _barAnimation;

  final List<String> _filters = [
    'Semua',
    '5⭐',
    '4⭐',
    '3⭐',
    '2⭐',
    '1⭐',
    'Belum Dibalas',
  ];

  final List<Map<String, dynamic>> _reviews = const [
    {
      'name': 'Andi Pratama',
      'rating': 5,
      'date': '10 Jun 2026',
      'comment':
          'Service cepat dan rapi. Mekanik ramah dan jujur soal harga. Sangat recommended! Pasti balik lagi.',
      'services': ['Ganti Oli', 'Tune Up'],
      'verified': true,
      'helpful': 12,
      'ownerReply':
          'Terima kasih Pak Andi! Senang bisa membantu. Ditunggu kunjungan berikutnya ya.',
    },
    {
      'name': 'Ratna Dewi',
      'rating': 5,
      'date': '8 Jun 2026',
      'comment':
          'Bengkel bersih, mekanik sabar menjelaskan kerusakan. Harga sesuai estimasi di app. Tidak ada biaya tersembunyi.',
      'services': ['Servis Berkala'],
      'verified': true,
      'helpful': 8,
      'ownerReply': null,
    },
    {
      'name': 'Budi Santoso',
      'rating': 4,
      'date': '5 Jun 2026',
      'comment':
          'Bagus overall, cuma agak lama nunggu antrian sekitar 30 menit. Tapi kualitas kerja oke dan mekanik komunikatif.',
      'services': ['Ganti Kampas Rem'],
      'verified': true,
      'helpful': 5,
      'ownerReply':
          'Terima kasih masukannya Pak Budi. Kami akan tingkatkan kecepatan layanan. Mohon maaf atas ketidaknyamanannya.',
    },
    {
      'name': 'Dewi Lestari',
      'rating': 5,
      'date': '2 Jun 2026',
      'comment':
          'Pertama kali service di sini, langsung jadi langganan. Mekaniknya jago dan ngerti banget masalah CVT. Top!',
      'services': ['CVT', 'Roller'],
      'verified': true,
      'helpful': 15,
      'ownerReply': null,
    },
    {
      'name': 'Reza Mahendra',
      'rating': 4,
      'date': '28 Mei 2026',
      'comment':
          'Harga fair dan transparan. Booking lewat app gampang banget. Cuma parkirnya agak sempit.',
      'services': ['Ganti Oli'],
      'verified': true,
      'helpful': 3,
      'ownerReply': null,
    },
    {
      'name': 'Siti Nurhaliza',
      'rating': 5,
      'date': '25 Mei 2026',
      'comment':
          'Sebagai perempuan sering khawatir ke bengkel, tapi di sini mekaniknya sopan dan jelas ngejelasinnya. Ruang tunggu juga nyaman.',
      'services': ['Servis Berkala', 'Ganti Aki'],
      'verified': true,
      'helpful': 22,
      'ownerReply':
          'Terima kasih Bu Siti! Kami memang berkomitmen memberikan pelayanan terbaik untuk semua pelanggan. Senang mendengarnya!',
    },
    {
      'name': 'Fahri Hidayat',
      'rating': 3,
      'date': '20 Mei 2026',
      'comment':
          'Kualitas kerja lumayan, tapi waktu pengerjaan melebihi estimasi yang dijanjikan. Harusnya 1 jam jadi hampir 2 jam.',
      'services': ['Tune Up', 'Ganti Filter'],
      'verified': true,
      'helpful': 7,
      'ownerReply': null,
    },
    {
      'name': 'Agus Wijaya',
      'rating': 5,
      'date': '18 Mei 2026',
      'comment':
          'Sudah 3x service di sini, selalu konsisten bagus. Mekanik hafal motor saya dan tahu history-nya. Mantap!',
      'services': ['Ganti Oli', 'Cek Mesin'],
      'verified': true,
      'helpful': 18,
      'ownerReply':
          'Terima kasih Pak Agus atas kepercayaannya selama ini! Kami senang bisa jadi bengkel langganan Bapak.',
    },
    {
      'name': 'Maya Putri',
      'rating': 2,
      'date': '15 Mei 2026',
      'comment':
          'Pelayanan oke tapi saya harus balik lagi karena masalah belum selesai tuntas. Harap lebih teliti.',
      'services': ['Perbaikan Kelistrikan'],
      'verified': true,
      'helpful': 4,
      'ownerReply': null,
    },
    {
      'name': 'Hendra Gunawan',
      'rating': 5,
      'date': '12 Mei 2026',
      'comment':
          'Emergency ban bocor malam-malam, untung bengkel ini buka sampai jam 9. Penyelamat! Harga wajar meski malam.',
      'services': ['Tambal Ban', 'Isi Angin'],
      'verified': true,
      'helpful': 31,
      'ownerReply':
          'Terima kasih Pak Hendra! Kami memang berkomitmen melayani di jam-jam yang dibutuhkan pelanggan.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _barAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _barAnimation = CurvedAnimation(
      parent: _barAnimationController,
      curve: Curves.easeOutCubic,
    );
    _barAnimationController.forward();
  }

  @override
  void dispose() {
    _barAnimationController.dispose();
    for (final controller in _replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredReviews {
    if (_selectedFilter == 'Semua') return _reviews;
    if (_selectedFilter == 'Belum Dibalas') {
      return _reviews
          .where((r) => r['ownerReply'] == null)
          .toList();
    }
    final starCount = int.tryParse(_selectedFilter.replaceAll('⭐', ''));
    if (starCount != null) {
      return _reviews.where((r) => r['rating'] == starCount).toList();
    }
    return _reviews;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildOverviewCard(),
                _buildFilterChips(),
                ..._filteredReviews.asMap().entries.map(
                      (entry) => _buildReviewCard(entry.key, entry.value),
                    ),
                _buildInsightsSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
      decoration: BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ulasan Pelanggan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Kelola feedback & bangun reputasi',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list_rounded, color: Colors.white),
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Ulasan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedFilter = filter);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryBlue
                          : AppTheme.primaryBlue.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryBlue
                            : AppTheme.primaryBlue.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : AppTheme.primaryBlue,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Big rating
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.shade100,
                            Colors.amber.shade50,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '4.8',
                                style: TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber.shade700,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '234 ulasan',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.successGreen.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.emoji_events_rounded,
                            size: 14,
                            color: AppTheme.successGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Top 5% Bandung',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.successGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // Right: Distribution bars
                Expanded(
                  child: AnimatedBuilder(
                    animation: _barAnimation,
                    builder: (context, child) {
                      return Column(
                        children: [
                          _buildDistributionBar(5, 0.80, 187),
                          _buildDistributionBar(4, 0.15, 35),
                          _buildDistributionBar(3, 0.03, 7),
                          _buildDistributionBar(2, 0.01, 3),
                          _buildDistributionBar(1, 0.01, 2),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistributionBar(int star, double percentage, int count) {
    final animatedValue = percentage * _barAnimation.value;
    Color barColor;
    switch (star) {
      case 5:
        barColor = const Color(0xFF4CAF50);
        break;
      case 4:
        barColor = const Color(0xFF8BC34A);
        break;
      case 3:
        barColor = const Color(0xFFFFC107);
        break;
      case 2:
        barColor = const Color(0xFFFF9800);
        break;
      default:
        barColor = const Color(0xFFF44336);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 14,
            child: Text(
              '$star',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textGrey,
              ),
            ),
          ),
          const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: animatedValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 28,
            child: Text(
              '$count',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppTheme.textGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryBlue
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryBlue
                        : Colors.grey.shade300,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryBlue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppTheme.textGrey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewCard(int index, Map<String, dynamic> review) {
    final hasOwnerReply = review['ownerReply'] != null;
    final hasSubmittedReply = _submittedReplies[index] != null;
    final isReplyExpanded = _replyExpanded[index] ?? false;
    final services = review['services'] as List<dynamic>;
    final name = review['name'] as String;
    final initials = name.split(' ').map((w) => w[0]).take(2).join();

    // Gradient colors for avatars based on index
    final gradientColors = [
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFFF093FB), const Color(0xFFF5576C)],
      [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      [const Color(0xFFFA709A), const Color(0xFFFEE140)],
      [const Color(0xFFA18CD1), const Color(0xFFFBC2EB)],
      [const Color(0xFFFCCB90), const Color(0xFFD57EEB)],
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFFE44D26), const Color(0xFFF16529)],
      [const Color(0xFF11998E), const Color(0xFF38EF7D)],
    ];

    final avatarGradient = gradientColors[index % gradientColors.length];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Avatar + Name + Date + Rating
            Row(
              children: [
                // Gradient avatar
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: avatarGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          if (review['verified'] == true) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.successGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified_rounded,
                                    size: 10,
                                    color: AppTheme.successGreen,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    'Verified',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.successGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        review['date'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                // Star rating
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (i) {
                    return Icon(
                      i < (review['rating'] as int)
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: i < (review['rating'] as int)
                          ? Colors.amber
                          : Colors.grey.shade300,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Service chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: services.map((service) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryBlue.withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    service.toString(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // Review text
            Text(
              review['comment'],
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textDark,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),

            // Helpful count
            Row(
              children: [
                Icon(
                  Icons.thumb_up_outlined,
                  size: 14,
                  color: AppTheme.textLight,
                ),
                const SizedBox(width: 4),
                Text(
                  '${review['helpful']} terbantu',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),

            // Owner reply section
            if (hasOwnerReply || hasSubmittedReply) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.store_rounded,
                          size: 14,
                          color: AppTheme.primaryBlue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Balasan Pemilik',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      hasSubmittedReply
                          ? _submittedReplies[index]!
                          : review['ownerReply'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textDark,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Reply button or inline text field
            if (!hasOwnerReply && !hasSubmittedReply) ...[
              const SizedBox(height: 10),
              if (!isReplyExpanded)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _replyExpanded[index] = true;
                      _replyControllers[index] ??= TextEditingController();
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.primaryBlue.withOpacity(0.15),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.reply_rounded,
                          size: 14,
                          color: AppTheme.primaryBlue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Balas',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                _buildReplyField(index),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReplyField(int index) {
    final controller =
        _replyControllers[index] ?? TextEditingController();
    _replyControllers[index] = controller;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            maxLines: 3,
            minLines: 2,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Terima kasih atas ulasannya...',
              hintStyle: TextStyle(
                fontSize: 12,
                color: AppTheme.textLight,
              ),
              contentPadding: const EdgeInsets.all(12),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _replyExpanded[index] = false;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Text(
                  'Batal',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textGrey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    _submittedReplies[index] = controller.text.trim();
                    _replyExpanded[index] = false;
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.send_rounded,
                        size: 13, color: Colors.white),
                    const SizedBox(width: 6),
                    const Text(
                      'Kirim',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsightsSection() {
    final frequentWords = [
      {'word': 'ramah', 'count': 45},
      {'word': 'cepat', 'count': 38},
      {'word': 'bersih', 'count': 32},
      {'word': 'murah', 'count': 28},
      {'word': 'jujur', 'count': 24},
      {'word': 'sopan', 'count': 21},
      {'word': 'komunikatif', 'count': 18},
      {'word': 'nyaman', 'count': 15},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.warningOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.insights_rounded,
                    size: 18,
                    color: AppTheme.warningOrange,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Insights Ulasan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Frequent words
            const Text(
              'Kata yang sering disebut',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textGrey,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: frequentWords.map((item) {
                final word = item['word'] as String;
                final count = item['count'] as int;
                final opacity = 0.5 + (count / 45) * 0.5;
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(opacity * 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primaryBlue.withOpacity(opacity * 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        word,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:
                              AppTheme.primaryBlue.withOpacity(opacity * 1.2 > 1 ? 1 : opacity * 1.2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($count)',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Improvement suggestions
            const Text(
              'Saran Peningkatan',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textGrey,
              ),
            ),
            const SizedBox(height: 10),
            _buildSuggestionItem(
              Icons.schedule_rounded,
              '3 pelanggan menyebutkan waktu tunggu terlalu lama',
              'Pertimbangkan sistem antrian yang lebih efisien',
            ),
            const SizedBox(height: 8),
            _buildSuggestionItem(
              Icons.local_parking_rounded,
              '2 pelanggan menyebutkan area parkir sempit',
              'Evaluasi layout area parkir pelanggan',
            ),
            const SizedBox(height: 8),
            _buildSuggestionItem(
              Icons.build_rounded,
              '1 pelanggan melaporkan masalah belum tuntas',
              'Terapkan quality check sebelum kendaraan diserahkan',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.warningOrange.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.warningOrange.withOpacity(0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppTheme.warningOrange),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
