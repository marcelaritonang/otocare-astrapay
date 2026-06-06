import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ServiceGrid extends StatelessWidget {
  final VoidCallback onBengkelTap;

  const ServiceGrid({super.key, required this.onBengkelTap});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'icon': Icons.receipt_long, 'label': 'Angsuran', 'onTap': null},
      {'icon': Icons.phone_android, 'label': 'Pulsa &\nPaket Data', 'onTap': null},
      {'icon': Icons.flash_on, 'label': 'PLN', 'onTap': null},
      {'icon': Icons.account_balance_wallet, 'label': 'Uang\nElektronik', 'onTap': null},
      {'icon': Icons.build, 'label': 'Bengkel', 'onTap': onBengkelTap, 'highlight': true},
      {'icon': Icons.card_giftcard, 'label': 'Gift\nVoucher', 'onTap': null},
      {'icon': Icons.directions_bus, 'label': 'Transportasi', 'onTap': null},
      {'icon': Icons.more_horiz, 'label': 'Lihat\nSemua', 'onTap': null},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Layanan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            final isHighlight = service['highlight'] == true;
            return GestureDetector(
              onTap: service['onTap'] as VoidCallback?,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isHighlight
                          ? AppTheme.primaryBlue
                          : AppTheme.primaryBlue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: isHighlight
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : null,
                    ),
                    child: Icon(
                      service['icon'] as IconData,
                      color: isHighlight ? Colors.white : AppTheme.primaryBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    service['label'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w400,
                      color: isHighlight ? AppTheme.primaryBlue : AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
