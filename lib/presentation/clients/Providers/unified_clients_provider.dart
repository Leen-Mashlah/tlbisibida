import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/data/repo/db_clients_repo.dart';
import 'package:lambda_dent_dash/services/navigation/locator.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/clients_page.dart';
import 'package:lambda_dent_dash/presentation/clients/client_details_page.dart';

enum ClientsPageType {
  clientsList,
  clientDetails,
}

class UnifiedClientsProvider extends StatelessWidget {
  final ClientsPageType pageType;

  const UnifiedClientsProvider({
    super.key,
    required this.pageType,
  });

  DBClientsRepo get clientsRepo => locator<DBClientsRepo>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientsCubit(clientsRepo),
      child: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    switch (pageType) {
      case ClientsPageType.clientsList:
        return ClientsPage();
      case ClientsPageType.clientDetails:
        final args = ModalRoute.of(context)?.settings.arguments;
        int? clientId;
        String? name;
        String? phone;
        String? address;
        if (args is Map<String, dynamic>) {
          clientId = args['id'] as int?;
          name = args['name'] as String?;
          final dynamic ph = args['phone'];
          phone = ph?.toString();
          address = args['address'] as String?;
        } else if (args is int) {
          clientId = args;
        }
        return ClientDetailsPage(
          clientId: clientId,
          initialName: name,
          initialPhone: phone,
          initialAddress: address,
        );
    }
  }
}
