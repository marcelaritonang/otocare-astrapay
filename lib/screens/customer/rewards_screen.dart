import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
        title: const Text('OtoCare Rewards', style: TextStyle(color: AppTheme.textDark, fontSize: 17, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildPointsHeader(),
            const SizedBox(height: 20),
            _buildLevelProgress(),
            const SizedBox(height: 20),
            _buildStreak(),
            const SizedBox(height: 20),
            _buildBadges(),
            const SizedBox(height: 20),
            _buildRedeemSection(),
            const SizedBox(height: 20),
            _buildHowToEarn(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565D8), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.stars_rounded, color: Colors.amber, size: 28),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Poin', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('2.350', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up, color: Colors.greenAccent, size: 16),
                SizedBox(width: 6),
                Text('+350 poin bulan ini', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelProgress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFC0C0C0).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Center(child: Text('🥈', style: TextStyle(fontSize: 22))),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Level Silver', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                    SizedBox(height: 2),
                    Text('Motor Terawat', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('🥇 Gold: 5.000', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFB8860B))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('2.350 / 5.000 pts', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                  Text('47%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primaryBlue)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: 0.47,
                  backgroundColor: const Color(0xFFF1F3F8),
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 6),
              const Text('2.650 poin lagi menuju Gold!', style: TextStyle(fontSize: 11, color: AppTheme.textGrey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreak() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFF59E0B).withOpacity(0.08), const Color(0xFFEF4444).withOpacity(0.05)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF59E0B).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3 Bulan Streak!', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                SizedBox(height: 2),
                Text('Service tepat waktu berturut-turut', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('+150 pts', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildBadges() {
    final badges = [
      {'emoji': '🔧', 'name': 'Service Pertama', 'desc': 'Service via OtoCare', 'unlocked': true},
      {'emoji': '💳', 'name': 'Cashless', 'desc': 'Bayar pakai AstraPay', 'unlocked': true},
      {'emoji': '⭐', 'name': 'Reviewer', 'desc': 'Beri rating bengkel', 'unlocked': true},
      {'emoji': '🏆', 'name': 'Loyal', 'desc': '5x service di 1 bengkel', 'unlocked': true},
      {'emoji': '💪', 'name': 'Motor Sehat', 'desc': '6 bulan skor >80%', 'unlocked': false},
      {'emoji': '🌟', 'name': 'VIP Member', 'desc': 'Capai Gold level', 'unlocked': false},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Badge Koleksi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              Text('4/6 terbuka', style: TextStyle(fontSize: 12, color: AppTheme.textGrey)),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
            children: badges.map((b) => _badgeCard(b)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _badgeCard(Map<String, dynamic> badge) {
    final unlocked = badge['unlocked'] as bool;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: unlocked ? AppTheme.primaryBlue.withOpacity(0.2) : const Color(0xFFE8EBF0)),
        boxShadow: unlocked ? [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)] : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            badge['emoji'] as String,
            style: TextStyle(fontSize: 24, color: unlocked ? null : Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            badge['name'] as String,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: unlocked ? AppTheme.textDark : AppTheme.textLight),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            badge['desc'] as String,
            style: TextStyle(fontSize: 9, color: unlocked ? AppTheme.textGrey : AppTheme.textLight),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (!unlocked)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(Icons.lock, size: 12, color: AppTheme.textLight),
            ),
        ],
      ),
    );
  }

  Widget _buildRedeemSection() {
    final rewards = [
      {'title': 'Cashback Rp 25.000', 'points': 1000, 'desc': 'Saldo AstraPay', 'icon': Icons.account_balance_wallet},
      {'title': 'Gratis Ganti Oli', 'points': 2000, 'desc': 'Bengkel partner', 'icon': Icons.oil_barrel},
      {'title': 'Diskon 50% Service', 'points': 1500, 'desc': 'Max Rp 100rb', 'icon': Icons.discount},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tukar Poin', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          ...rewards.map((r) => _rewardCard(r)),
        ],
      ),
    );
  }

  Widget _rewardCard(Map<String, dynamic> reward) {
    final canRedeem = 2350 >= (reward['points'] as int);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(reward['icon'] as IconData, color: AppTheme.primaryBlue, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reward['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                Text(reward['desc'] as String, style: const TextStyle(fontSize: 11, color: AppTheme.textGrey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${reward['points']} pts', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: canRedeem ? AppTheme.primaryBlue : AppTheme.textLight)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: canRedeem ? AppTheme.primaryBlue : const Color(0xFFF1F3F8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Tukar', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: canRedeem ? Colors.white : AppTheme.textLight)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowToEarn() {
    final ways = [
      {'action': 'Service via OtoCare', 'points': '+100 pts', 'icon': Icons.build},
      {'action': 'Bayar pakai AstraPay', 'points': '+50 pts', 'icon': Icons.payment},
      {'action': 'Review bengkel', 'points': '+25 pts', 'icon': Icons.star},
      {'action': 'Streak bulanan', 'points': '+150 pts', 'icon': Icons.local_fire_department},
      {'action': 'Referral teman', 'points': '+200 pts', 'icon': Icons.people},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.emoji_events, color: Color(0xFFF59E0B), size: 18),
              SizedBox(width: 8),
              Text('Cara Dapat Poin', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            ],
          ),
          const SizedBox(height: 14),
          ...ways.map((w) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(w['icon'] as IconData, color: AppTheme.primaryBlue, size: 18),
                const SizedBox(width: 10),
                Expanded(child: Text(w['action'] as String, style: const TextStyle(fontSize: 13, color: AppTheme.textDark))),
                Text(w['points'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.successGreen)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
