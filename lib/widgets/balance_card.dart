import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Column(
        children: [
          // Saldo row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: AppTheme.primaryBlue, size: 18),
                      const SizedBox(width: 6),
                      const Text(
                        'Saldo',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textGrey,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.visibility_outlined,
                          color: AppTheme.textGrey, size: 16),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Rp5.000.000',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
              // Quick actions
              Row(
                children: [
                  _quickAction(Icons.add, 'Top Up'),
                  const SizedBox(width: 14),
                  _quickAction(Icons.swap_horiz, 'Transfer'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Divider
          Container(
            height: 1,
            color: Colors.grey.shade100,
          ),
          const SizedBox(height: 14),
          // AstraPoints & Voucher
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.stars, color: Colors.amber, size: 16),
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AstraPoints',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.textGrey,
                          ),
                        ),
                        Text(
                          '1.000.000',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: Colors.grey.shade200,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.confirmation_number,
                          color: AppTheme.primaryBlue, size: 16),
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Voucher Toko',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.textGrey,
                          ),
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 22),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppTheme.textGrey),
        ),
      ],
    );
  }
}
