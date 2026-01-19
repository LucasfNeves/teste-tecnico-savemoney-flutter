import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_create_flutter/domain/models/user_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:teste_create_flutter/core/theme/app_theme.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_bloc.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_state.dart';
import 'package:teste_create_flutter/presentation/blocs/user/user_event.dart';
import 'package:teste_create_flutter/shared/components/modal_drag_handle.dart';
import 'package:teste_create_flutter/shared/components/phone_areacode_input/models/phone_data.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/owner_user_card_avatar.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/owner-card-details/owner_user_card_form.dart';
import 'package:teste_create_flutter/presentation/screens/users-list/components/owner-user-card/components/owner_user_card_actions.dart';

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

  String? _userName;
  String? _userEmail;
  List<PhoneData>? _userPhones;
  List<PhoneData>? _currentPhones;
  bool _shouldCloseOnNextSuccess = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    final state = context.read<UserBloc>().state;

    if (state is UserSuccess && _userName == null) {
      final user = state.user;

      setState(() {
        _userName = user.displayName;
        _userEmail = user.email;
        _userPhones = user.telephones.toPhoneDataList();
        _currentPhones = List.from(_userPhones!);
        _nameController.text = user.displayName;
        _emailController.text = user.email;
      });
    }
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final data = <String, dynamic>{
      'name': _nameController.text,
      'email': _emailController.text,
      'telephones': _currentPhones!.toJsonList(),
    };

    if (_passwordController.text.isNotEmpty) {
      data['password'] = _passwordController.text;
    }

    context.read<UserBloc>().add(
          UpdateUserProfileRequested(data),
        );
  }

  void _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text(
          'Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Excluir',
              style: TextStyle(color: AppTheme.errorRed),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<UserBloc>().add(DeleteUserAccountRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUpdateSuccess) {
          _shouldCloseOnNextSuccess = true;
        } else if (state is UserSuccess) {
          if (_shouldCloseOnNextSuccess) {
            Navigator.pop(context);
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Perfil atualizado com sucesso!',
              ),
            );
            _shouldCloseOnNextSuccess = false;
          } else {
            _loadUserData();
          }
        } else if (state is UserUpdateError) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: state.message,
            ),
          );
        } else if (state is UserDeleteSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/login');
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: 'Conta excluída com sucesso!',
            ),
          );
        } else if (state is UserDeleteError) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: state.message,
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          decoration: const BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ModalDragHandle(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 16,
                    bottom: 24,
                  ),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_userName == null || _userEmail == null || _userPhones == null) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OwnerUserCardAvatar(initial: widget.initial),
        const SizedBox(height: 24),
        OwnerUserCardForm(
          formKey: _formKey,
          nameController: _nameController,
          emailController: _emailController,
          passwordController: _passwordController,
          userPhones: _userPhones!,
          onPhonesChanged: (phones) {
            setState(() {
              _currentPhones = phones;
            });
          },
        ),
        const SizedBox(height: 40),
        OwnerUserCardActions(
          onUpdate: _handleSubmit,
          onDelete: _handleDelete,
        ),
      ],
    );
  }
}
