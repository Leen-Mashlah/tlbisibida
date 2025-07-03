import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/profile/components/edit_profile_dialog.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({super.key});
  List userInfo = [
    {
      'title': 'البريد الالكتروني',
      'info': 'hamwi.lab@gmail.com',
      // controller.profileModel!.firstName +
      //     controller.profileModel!.lastName,
      'icon': Icons.mail_rounded,
    },
    {
      'title': 'الهاتف',
      'info': '+963 999 222 111',
      //  controller.profileModel!.phoneNumber,
      'icon': CupertinoIcons.phone_circle_fill,
    },
    {
      'title': 'العنوان',
      'info': 'دمشق - ساحة الجبة',
      //controller.profileModel!.wallet,
      'icon': Icons.location_on_rounded,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20),
              Text('Hamwi Lab',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: cyan600)),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width / 5,
                height: .5,
                color: cyan300,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        itemBuilder(userInfo[index]),
                    separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: cyan400,
                        ),
                    itemCount: userInfo.length),
              ),
              SizedBox(height: 20),
              defaultButton(
                  text: 'تعديل',
                  textsize: 18,
                  function: () {
                    showDialog(
                      builder: (context) => EditProfileDialog(),
                      context: context,
                    );
                  }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  itemBuilder(model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            model['icon'],
            color: cyan500,
          ),
          Text(model['info'].toString(),
              style: TextStyle(
                fontSize: 20,
                color: cyan600,
                //color: Colors.blueGrey,
              )),
        ],
      ),
    );
  }
}

class AccountsSection extends StatelessWidget {
  const AccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child:
              // CircleAvatar(
              //     //child: ,
              //     radius: 100,
              //     backgroundColor: const Color.fromARGB(0, 255, 255, 255),
              //     backgroundImage: AssetImage('profile.png')
              //     //minRadius: 20,
              //     ),
              Image.asset(
            'Profile.png',
            width: MediaQuery.of(context).size.width / 2.5,
            height: 180,
          )),
    );
  }
}

class SubscriptionStatus extends StatelessWidget {
  const SubscriptionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('الاشتراك',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: cyan600)),
            SizedBox(height: 20),
            BillItem(title: 'حالة الاشتراك - فعال', isPaid: true),
            SizedBox(height: 20),
            Text(
              'بداية الاشتراك: ' + '22/4/2025',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'نهاية الاشتراك: ' + '22/4/2026',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class BillItem extends StatelessWidget {
  final String title;
  final bool isPaid;

  BillItem({super.key, required this.title, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(isPaid ? Icons.check_circle : Icons.cancel,
            color: isPaid ? Colors.green : Colors.red),
      ],
    );
  }
}
