import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constant/constants/constants.dart';
import 'package:lambda_dent_dash/view/profile/components/edit_profile_dialog.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({super.key});
  List userInfo = [
    {
      'title': 'البريد الالكتروني',
      'info': 'hamwi.lab@gmail.com',
      // controller.profileModel!.firstName +
      //     controller.profileModel!.lastName,
      'icon': Icons.person,
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
      'icon': Icons.credit_card_rounded,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 4,
                  child: Image.asset('profile.jpg')),
              SizedBox(height: 10),
              Text('Hamwi Lab',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 5,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        itemBuilder(userInfo[index]),
                    separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                    itemCount: userInfo.length),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text(
                  'تعديل',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => showDialog(
                  builder: (context) => EditProfileDialog(),
                  context: context,
                ),
                style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size(200, 50)),
                    foregroundColor: WidgetStatePropertyAll(white),
                    backgroundColor: WidgetStatePropertyAll(cyan500)),
              ),
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
            color: Colors.blueGrey,
          ),
          Text(model['info'].toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My xPay accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Active account: 8430 8600 4256 4256'),
            ElevatedButton(onPressed: () {}, child: Text('Block Account')),
            SizedBox(height: 10),
            Text('Blocked account: 8430 8600 4256 4256'),
            ElevatedButton(onPressed: () {}, child: Text('Unblock Account')),
          ],
        ),
      ),
    );
  }
}

class BillsSection extends StatelessWidget {
  const BillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My bills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            BillItem(title: 'Phone bill', isPaid: true),
            BillItem(title: 'Internet bill', isPaid: false),
            BillItem(title: 'House rent', isPaid: true),
            BillItem(title: 'Income tax', isPaid: true),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Icon(isPaid ? Icons.check_circle : Icons.cancel,
            color: isPaid ? Colors.green : Colors.red),
      ],
    );
  }
}
