import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/tusk_icons.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/lab_clients/lab_client.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_cubit.dart';
import 'package:lambda_dent_dash/presentation/clients/Cubits/clients_state.dart';

// A custom widget that acts as a button and shows a searchable list
// in a bottom modal sheet when pressed.
class ChoiceButtonWithSearch extends StatefulWidget {
  // Optional initial selected client.
  final Client? initialClient;
  // Callback function when a client is selected.
  final ValueChanged<Client>? onClientSelected;
  // Text to display when no client is selected initially.
  final String hintText;
  // ClientsCubit instance to use for loading clients
  final ClientsCubit? clientsCubit;

  const ChoiceButtonWithSearch({
    Key? key,
    this.initialClient,
    this.onClientSelected,
    this.hintText = 'اختر الزبون',
    this.clientsCubit,
  }) : super(key: key);

  @override
  _ChoiceButtonWithSearchState createState() => _ChoiceButtonWithSearchState();
}

class _ChoiceButtonWithSearchState extends State<ChoiceButtonWithSearch> {
  // The currently selected client displayed on the button.
  Client? _selectedClient;

  @override
  void initState() {
    super.initState();
    // Initialize the selected client with the initial client provided,
    // or null if none is provided.
    _selectedClient = widget.initialClient;
  }

  // Function to show the bottom modal sheet for client selection.
  void _showClientSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take up more height
      builder: (BuildContext context) {
        // Return the content of the bottom modal sheet.
        return ClientSelectionSheetContent(
          onClientSelected: (client) {
            // Update the selected client in the parent widget's state.
            setState(() {
              _selectedClient = client;
            });
            // Call the user-provided callback if it exists.
            widget.onClientSelected?.call(client);
            // Close the modal sheet.
            Navigator.pop(context);
          },
          clientsCubit: widget.clientsCubit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // The button widget that displays the selected client or hint text.
    return InkWell(
      onTap: _showClientSelectionSheet,
      child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: cyan200,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: cyan500,
                width: 1,
              )),
          // Show the modal sheet when pressed.
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedClient?.name ??
                      widget.hintText, // Display selected client name or hint.
                  style: TextStyle(
                    // Customize text style as needed.
                    color: cyan600,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 60),
                    child: Icon(
                      TuskIcons.lab_icon,
                      color: cyan600,
                    ))
              ],
            ),
          )),
    );
  }
}

// The content widget for the bottom modal sheet containing the searchable list.
class ClientSelectionSheetContent extends StatefulWidget {
  final ValueChanged<Client> onClientSelected;
  final ClientsCubit? clientsCubit;

  const ClientSelectionSheetContent({
    Key? key,
    required this.onClientSelected,
    this.clientsCubit,
  }) : super(key: key);

  @override
  _ClientSelectionSheetContentState createState() =>
      _ClientSelectionSheetContentState();
}

class _ClientSelectionSheetContentState
    extends State<ClientSelectionSheetContent> {
  // Controller for the search text field.
  final TextEditingController _searchController = TextEditingController();
  // The full list of clients, sorted alphabetically.
  late List<Client> _allClients;
  // The list of clients currently displayed, filtered by the search query.
  List<Client> _filteredClients = [];

  @override
  void initState() {
    super.initState();
    // Load clients from API
    _loadClients();

    // Add a listener to the search controller to filter the list as the user types.
    _searchController.addListener(_filterClients);
  }

  @override
  void dispose() {
    // Clean up the search controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  // Load clients from API
  Future<void> _loadClients() async {
    if (widget.clientsCubit != null) {
      await widget.clientsCubit!.getClients();
    }
  }

  // Function to filter the list of clients based on the search query.
  void _filterClients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      // If the query is empty, show all clients.
      if (query.isEmpty) {
        _filteredClients = _allClients;
      } else {
        // Filter clients that contain the query (case-insensitive).
        _filteredClients = _allClients.where((client) {
          return client.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the height of the modal sheet. Adjust as needed.
    // Using MediaQuery to get the screen height and setting a fraction of it.
    final double sheetHeight =
        MediaQuery.of(context).size.height * 0.6; // 60% of screen height

    return Container(
      decoration: BoxDecoration(
          color: cyan50,
          border: Border.all(width: 1, color: cyan300),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      height: sheetHeight,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Adjust padding for keyboard
      ),
      child: Column(
        children: [
          // Search bar text field.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'ابحث عن زبون',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Expanded widget to make the list take up the remaining space.
          Expanded(
            child: widget.clientsCubit != null
                ? BlocBuilder<ClientsCubit, ClientsState>(
                    bloc: widget.clientsCubit,
                    builder: (context, state) {
                      if (state is ClientsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ClientsLoaded) {
                        // Update the clients list
                        _allClients = state.clientsResponse.clients;
                        if (_filteredClients.isEmpty) {
                          _filteredClients = _allClients;
                        }

                        return ListView.builder(
                          itemCount: _filteredClients.length,
                          itemBuilder: (context, index) {
                            final client = _filteredClients[index];
                            // List tile for each client.
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(client.name),
                                subtitle: Text(client.phone.toString()),
                                onTap: () {
                                  // Call the callback function with the selected client.
                                  widget.onClientSelected(client);
                                },
                              ),
                            );
                          },
                        );
                      } else if (state is ClientsError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else {
                        return const Center(child: Text('No clients found'));
                      }
                    },
                  )
                : const Center(child: Text('ClientsCubit not available')),
          ),
        ],
      ),
    );
  }
}
