import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_inventory_repo.dart';
import 'package:lambda_dent_dash/domain/repo/inv_repo.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';

class InventoryProvider extends StatelessWidget {
  final Widget child;

  InventoryProvider({super.key, required this.child});

  final InvRepo inventoryRepo = locator<DbInventoryRepo>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InventoryCubit(inventoryRepo),
        ),
      ],
      child: child,
    );
  }
}
