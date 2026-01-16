import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:teste_create_flutter/shared/components/primary_button.dart';
import 'package:teste_create_flutter/shared/components/secundary_button.dart';

class OwnerUserCardActions extends StatelessWidget {
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const OwnerUserCardActions({
    super.key,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isUpdateLoading = state is UserUpdateLoading;
        final isDeleteLoading = state is UserDeleteLoading;
        final isAnyLoading = isUpdateLoading || isDeleteLoading;

        return Column(
          children: [
            PrimaryButton(
              text: 'Atualizar Perfil',
              isLoading: isUpdateLoading,
              onPressed: isAnyLoading ? null : onUpdate,
            ),
            const SizedBox(height: 16),
            SecundaryButton(
              key: const Key('delete_account_button'),
              label: isDeleteLoading ? 'Excluindo...' : 'Excluir Conta',
              icon: Icons.delete,
              onPressed: isAnyLoading ? () {} : onDelete,
            ),
          ],
        );
      },
    );
  }
}
