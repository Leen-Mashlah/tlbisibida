import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_auth_repo.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/authentication.dart';

class AuthProvider extends StatelessWidget {
  AuthProvider({super.key});
  final DBAuthRepo authrepo = locator<DBAuthRepo>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authrepo),
      child: AuthenticationPage(),
    );
  }
}
