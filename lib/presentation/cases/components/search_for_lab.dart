import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/components/tusk_icons.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

// A custom widget that acts as a button and shows a searchable list
// in a bottom modal sheet when pressed.
class ChoiceButtonWithSearch extends StatefulWidget {
  // The list of names to display in the selection sheet.
  final List<String> names;
  // Optional initial selected name.
  final String? initialName;
  // Callback function when a name is selected.
  final ValueChanged<String>? onNameSelected;
  // Text to display when no name is selected initially.
  final String hintText;

  const ChoiceButtonWithSearch({
    Key? key,
    required this.names,
    this.initialName,
    this.onNameSelected,
    this.hintText = 'اختر الزبون',
  }) : super(key: key);

  @override
  _ChoiceButtonWithSearchState createState() => _ChoiceButtonWithSearchState();
}

class _ChoiceButtonWithSearchState extends State<ChoiceButtonWithSearch> {
  // The currently selected name displayed on the button.
  String? _selectedName;

  @override
  void initState() {
    super.initState();
    // Initialize the selected name with the initial name provided,
    // or null if none is provided.
    _selectedName = widget.initialName;
  }

  // Function to show the bottom modal sheet for name selection.
  void _showNameSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take up more height
      builder: (BuildContext context) {
        // Return the content of the bottom modal sheet.
        return NameSelectionSheetContent(
          names: widget.names,
          onNameSelected: (name) {
            // Update the selected name in the parent widget's state.
            setState(() {
              _selectedName = name;
            });
            // Call the user-provided callback if it exists.
            widget.onNameSelected?.call(name);
            // Close the modal sheet.
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // The button widget that displays the selected name or hint text.
    return InkWell(
      onTap: _showNameSelectionSheet,
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
                  _selectedName ??
                      widget.hintText, // Display selected name or hint.
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
class NameSelectionSheetContent extends StatefulWidget {
  final List<String> names;
  final ValueChanged<String> onNameSelected;

  const NameSelectionSheetContent({
    Key? key,
    required this.names,
    required this.onNameSelected,
  }) : super(key: key);

  @override
  _NameSelectionSheetContentState createState() =>
      _NameSelectionSheetContentState();
}

class _NameSelectionSheetContentState extends State<NameSelectionSheetContent> {
  // Controller for the search text field.
  final TextEditingController _searchController = TextEditingController();
  // The full list of names, sorted alphabetically.
  late List<String> _allNames;
  // The list of names currently displayed, filtered by the search query.
  List<String> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    // Sort the initial list of names alphabetically (Arabic sorting).
    // Using compareTo for basic alphabetical sorting. For more complex
    // Arabic sorting rules (e.g., ignoring diacritics), you might need
    // a more specialized sorting function or library.
    _allNames = List.from(widget.names)..sort((a, b) => a.compareTo(b));
    // Initially, the filtered list contains all names.
    _filteredNames = _allNames;

    // Add a listener to the search controller to filter the list as the user types.
    _searchController.addListener(_filterNames);
  }

  @override
  void dispose() {
    // Clean up the search controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  // Function to filter the list of names based on the search query.
  void _filterNames() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      // If the query is empty, show all names.
      if (query.isEmpty) {
        _filteredNames = _allNames;
      } else {
        // Filter names that contain the query (case-insensitive).
        _filteredNames = _allNames.where((name) {
          return name.toLowerCase().contains(query);
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
            child: ListView.builder(
              itemCount: _filteredNames.length,
              itemBuilder: (context, index) {
                final name = _filteredNames[index];
                // List tile for each name.
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(name),
                    onTap: () {
                      // Call the callback function with the selected name.
                      widget.onNameSelected(name);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
