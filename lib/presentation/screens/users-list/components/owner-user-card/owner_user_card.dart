import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/owner-card-details/owner_user_card_details.dart';
import 'package:teste_create_flutter/shared/utils/strings_utils.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/components/smal_text_with_icon.dart';
import '../../../../../domain/models/user_model.dart';

class OwnerUserCard extends StatelessWidget {
  final User user;

  const OwnerUserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return GestureDetector(
      onTap: () => OwnerUserCardDetails.show(
        context,
        userBloc: userBloc,
        name: user.displayName,
        email: user.email,
        initial: user.initial,
        phones: user.formattedPhones,
      ),
      child: Card(
        color: AppTheme.accentPurple,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(
            color: AppTheme.primaryPurple,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.globalPadding),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppTheme.primaryPurple,
                  child: Text(
                    user.initial,
                    style: const TextStyle(
                      color: AppTheme.accentPurple,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName.truncateWithEllipsis(15),
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      SmalTextWithIcon(icon: Icons.email, text: user.email),
                      const SizedBox(height: 8),
                      SmalTextWithIcon(
                          icon: Icons.phone,
                          text:
                              '${user.telephones.length} Telefone${user.telephones.length > 1 ? 's' : ''}'),
                      const SizedBox(height: 8),
                      Container(
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
                  ),
                ),
                const SizedBox(width: 16),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
