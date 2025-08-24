import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/default_button.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/presentation/authentication/Cubits/auth_cubit.dart';
import 'package:lambda_dent_dash/presentation/profile/components/edit_profile_dialog.dart';

class ProfileSection extends StatelessWidget {
  ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit cubit = context.read<AuthCubit>();

    // Check if profile exists and has required data
    if (cubit.profile == null || cubit.profile!.profileDetails == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Icon(Icons.person_off, size: 64, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'No profile data available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    final profileDetails = cubit.profile!.profileDetails!;

    List userInfo = [
      {
        'title': 'البريد الالكتروني',
        'info': profileDetails.email ?? 'غير محدد',
        'icon': Icons.mail_rounded,
      },
      {
        'title': 'الهاتف',
        'info': profileDetails.labPhone ?? [],
        'icon': CupertinoIcons.phone_circle_fill,
      },
      {
        'title': 'العنوان',
        'info': profileDetails.labAddress ?? 'غير محدد',
        'icon': Icons.location_on_rounded,
      },
    ];

    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20),
              Text(
                profileDetails.labName ?? 'اسم المختبر',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: cyan600,
                ),
              ),
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
          Text(phoneNumberFix(model),
              style: TextStyle(
                fontSize: 20,
                color: cyan600,
              )),
        ],
      ),
    );
  }

  String phoneNumberFix(model) {
    if (model['title'] == 'الهاتف') {
      List<String> phones = model['info'] as List<String>;
      if (phones.isEmpty) {
        return 'غير محدد';
      }
      String phonesText = '';
      for (var phone in phones) {
        phonesText += phone + '\n';
      }
      return phonesText.trim();
    } else {
      return model['info'].toString();
    }
  }
}

class AccountsSection extends StatelessWidget {
  const AccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit cubit = context.read<AuthCubit>();

    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Image.asset(
            'Profile.png', //TODO add image download
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
    final AuthCubit cubit = context.read<AuthCubit>();

    // Check if profile and subscription data exists
    if (cubit.profile == null || cubit.profile!.lastSubscription == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('الاشتراك',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: cyan600)),
              SizedBox(height: 20),
              Text(
                'لا توجد بيانات اشتراك متاحة',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    final subscription = cubit.profile!.lastSubscription!;
    String status =
        subscription.subscriptionIsValid == true ? 'فعال' : 'منتهي الصلاحية';

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
            BillItem(
                title: 'حالة الاشتراك - $status',
                isPaid: subscription.subscriptionIsValid == true),
            SizedBox(height: 20),
            Text(
              'بداية الاشتراك: ${subscription.subscriptionFrom?.toString() ?? 'غير محدد'}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'نهاية الاشتراك: ${subscription.subscriptionTo?.toString() ?? 'غير محدد'}',
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
