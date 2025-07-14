import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_state.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/services/navigation/navigation_service.dart';
import 'package:lambda_dent_dash/services/navigation/routes.dart';
import 'package:lambda_dent_dash/presentation/profile/components/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          locator<NavigationService>().navigateTo(rolePageRoute);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = context.read<AuthCubit>();
        if (state is AuthProfileLoaded) {
          final profile = state.profile;
          // Use profile here
        }
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
            child: Column(
              children: [
                Card(
                  color: const Color.fromARGB(215, 211, 241, 238),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: ProfileSection()),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AccountsSection(),
                              SizedBox(height: 20),
                              SubscriptionStatus(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultButton(
                    text: 'تسجيل الخروج',
                    function: () {
                      authCubit.logout();
                    })
              ],
            ));
      },
    );
  }
}
