import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/shared/components/secundary_button.dart';
import '../../../../../../shared/components/custom_input.dart';
import '../../../../../../shared/components/modal_drag_handle.dart';
import '../../../../../../shared/components/multiple_phone_input.dart';
import '../../../../../../shared/components/primary_button.dart';

class OwnerUserCardDetails extends StatefulWidget {
  final String name;
  final String email;
  final String initial;
  final List<String> phones;

  const OwnerUserCardDetails({
    super.key,
    required this.name,
    required this.email,
    required this.initial,
    required this.phones,
  });
  static void show(
    BuildContext context, {
    required String name,
    required String email,
    required String initial,
    required List<String> phones,
    required UserBloc userBloc,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: userBloc,
        child: OwnerUserCardDetails(
          name: name,
          email: email,
          initial: initial,
          phones: phones,
        ),
      ),
    );
  }

  @override
  State<OwnerUserCardDetails> createState() => _OwnerUserCardDetailsState();
}

class _OwnerUserCardDetailsState extends State<OwnerUserCardDetails> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  List<Map<String, dynamic>> _phones = [];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<UserBloc>().stream,
      initialData: context.read<UserBloc>().state,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data is UserSuccess) {
          final user = (snapshot.data as UserSuccess).user;

          print(user.telephones);

          if (_nameController.text.isEmpty) {
            _nameController.text = user.displayName;
            _emailController.text = user.email;
            _phones = user.telephones
                .map((t) => {
                      'number': t.formattedNumber,
                      'ddd': t.areaCode,
                    })
                .toList();
          }
        }

        return BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Perfil atualizado com sucesso!')),
              );
            }
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ModalDragHandle(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 16,
                        bottom: 24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: AppTheme.primaryPurple,
                            child: Text(
                              widget.initial,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomInput(
                                  label: 'Nome Completo',
                                  type: InputType.name,
                                  controller: _nameController,
                                ),
                                const SizedBox(height: 20),
                                CustomInput(
                                  label: 'E-mail',
                                  type: InputType.email,
                                  controller: _emailController,
                                ),
                                const SizedBox(height: 20),
                                CustomInput(
                                  label: 'Nova Senha',
                                  type: InputType.password,
                                  controller: _passwordController,
                                ),
                                const SizedBox(height: 20),
                                MultiplePhoneInput(
                                  onChanged: (phones) {
                                    setState(() => _phones = phones);
                                  },
                                ),
                                const SizedBox(height: 40),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    return PrimaryButton(
                                      text: 'Atualizar Perfil',
                                      isLoading: state is UserUpdateLoading,
                                      onPressed: state is UserUpdateLoading
                                          ? null
                                          : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context.read<UserBloc>().add(
                                                      UpdateUserProfileRequested(
                                                        {
                                                          'name':
                                                              _nameController
                                                                  .text
                                                                  .trim(),
                                                          'email':
                                                              _emailController
                                                                  .text
                                                                  .trim(),
                                                          'password':
                                                              _passwordController
                                                                  .text,
                                                          'telephones': _phones,
                                                        },
                                                      ),
                                                    );
                                              }
                                            },
                                    );
                                  },
                                ),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    return SecundaryButton(
                                      key: const Key('delete_account_button'),
                                      label: 'Excluir Conta',
                                      icon: Icons.delete,
                                      onPressed: () {
                                        if (state is! UserUpdateLoading &&
                                            _formKey.currentState!.validate()) {
                                          context.read<UserBloc>().add(
                                              DeleteUserAccountRequested());
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
