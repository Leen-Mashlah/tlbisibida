import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_auth_repo.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/authentication.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/register.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/register_2.dart';
import 'package:lambda_dent_dash/presentation/profile/profile_page.dart';

enum AuthPageType {
  authentication,
  register,
  register2,
  profile,
}

class UnifiedAuthProvider extends StatelessWidget {
  final AuthPageType pageType;

  const UnifiedAuthProvider({
    super.key,
    required this.pageType,
  });

  DBAuthRepo get authrepo => locator<DBAuthRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authrepo),
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    switch (pageType) {
      case AuthPageType.authentication:
        return AuthenticationPage();
      case AuthPageType.register:
        return RegisterPage();
      case AuthPageType.register2:
        return Register2Page();
      case AuthPageType.profile:
        return const ProfilePage();
    }
  }
}
