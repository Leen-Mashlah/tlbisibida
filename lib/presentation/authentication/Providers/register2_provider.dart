import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_auth_repo.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/register_2.dart';

class Register2Provider extends StatelessWidget {
  Register2Provider({super.key});
  final DBAuthRepo authrepo = locator<DBAuthRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authrepo),
      child: Register2Page(),
    );
  }
}
