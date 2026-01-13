import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/components/smal_text_with_icon.dart';

class UserDetailsModal extends StatelessWidget {
  final String name;
  final String email;
  final String initial;
  final List<String> phones;
  final bool isOwner;

  const UserDetailsModal({
    super.key,
    required this.name,
    required this.email,
    required this.initial,
    required this.phones,
    this.isOwner = false,
  });

  static void show(
    BuildContext context, {
    required String name,
    required String email,
    required String initial,
    required List<String> phones,
    bool isOwner = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserDetailsModal(
        name: name,
        email: email,
        initial: initial,
        phones: phones,
        isOwner: isOwner,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppTheme.primaryPurple,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    if (isOwner) ...[
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Você',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SmalTextWithIcon(icon: Icons.email, text: email),
          const SizedBox(height: 16),
          Text(
            'Telefones',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          ...phones.map((phone) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SmalTextWithIcon(icon: Icons.phone, text: phone),
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
