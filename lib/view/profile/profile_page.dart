import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/view/profile/components/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 40.0),
        child: Card(
          // color: const Color.fromARGB(61, 245, 245, 245),
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
                  child: Column(
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
        ));
  }
}
