import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_clients_repo.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/client_details_page.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';

class ClientDetailsProvider extends StatelessWidget {
  ClientDetailsProvider({super.key});
  final DBClientsRepo clientsRepo = locator<DBClientsRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientsCubit(clientsRepo),
      child: ClientDetailsPage(),
    );
  }
}
