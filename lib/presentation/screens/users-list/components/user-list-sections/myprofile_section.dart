import 'package:flutter/material.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/user_card_error.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/user_card_skeleton.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/owner_user_card.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/user-list-sections/section_title.dart';

class MyProfileSection extends StatelessWidget {
  const MyProfileSection({super.key, required this.userBloc});

  final UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Meu Perfil'),
        const SizedBox(height: 12),
        StreamBuilder<UserState>(
          stream: userBloc.stream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state == null || state is UserLoading) {
              return const UserCardSkeleton();
            }

            if (state is UserSuccess) {
              return OwnerUserCard(user: state.user);
            }

            if (state is UserError) {
              return UserCardError(
                onRetry: () => userBloc.add(const GetUserRequested()),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
