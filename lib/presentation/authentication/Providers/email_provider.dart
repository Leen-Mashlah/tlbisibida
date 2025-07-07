import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_email_repo.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/email_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Views/email_verification.dart';

class EmailVerifyProvider extends StatelessWidget {
  EmailVerifyProvider({super.key});
  final DBEmailRepo emailRepo = locator<DBEmailRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailCubit(emailRepo),
      child: EmailVerificationPage(email: CacheHelper.get('email'),),
    );
  }
}
