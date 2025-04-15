import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/view/profile/components/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 40.0),
        child: Card(
          color: const Color.fromARGB(61, 245, 245, 245),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        SizedBox(height: 40),
                        BillsSection(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
