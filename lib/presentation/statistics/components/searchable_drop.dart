import 'package:flutter/material.dart';
import 'package:lambda_dent_dash/constants/constants.dart';

// Define a data structure for categorized items
class CategoryItem {
  final String categoryName;
  final List<String> items;

  CategoryItem({required this.categoryName, required this.items});
}

class SearchableExpandableDropdown extends StatefulWidget {
  final List<CategoryItem> data;
  final String hintText;
  final ValueChanged<String?>? onChanged;

  SearchableExpandableDropdown({
    Key? key,
    required this.data,
    this.hintText = 'اختر مادة',
    this.onChanged,
  }) : super(key: key);

  @override
  _SearchableExpandableDropdownState createState() =>
      _SearchableExpandableDropdownState();
}

class _SearchableExpandableDropdownState
    extends State<SearchableExpandableDropdown> {
  final TextEditingController _searchController = TextEditingController();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;
  String? _selectedItem;
  List<CategoryItem> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData = widget.data; // Initially show all data
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  // Handle changes in the search text field
  void _onSearchChanged() {
    print('Search text changed: ${_searchController.text}'); // Debug print
    _filterData(_searchController.text);

    // If the dropdown is currently open, remove the old overlay and show a new one
    // to ensure the filtered list is displayed.
    if (_isDropdownOpen) {
      _overlayEntry?.remove(); // Remove the old overlay
      _overlayEntry =
          _createOverlayEntry(); // Create a new overlay with updated data
      Overlay.of(context).insert(_overlayEntry!); // Insert the new overlay
    } else if (_searchController.text.isNotEmpty) {
      // If text is entered and dropdown is not open, show it.
      _showDropdown();
    }
    // If text is cleared and dropdown is closed, do nothing.
  }

  // Filter the data based on the search text
  void _filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredData = widget.data;
      });
      print(
          'Filter cleared. _filteredData count: ${_filteredData.length}'); // Debug print
      return;
    }

    final lowerCaseQuery = query.toLowerCase();
    final filtered = widget.data
        .map((category) {
          final filteredItems = category.items
              .where((item) => item.toLowerCase().contains(lowerCaseQuery))
              .toList();
          // Only include the category if it has matching items OR if the category name matches
          if (filteredItems.isNotEmpty ||
              category.categoryName.toLowerCase().contains(lowerCaseQuery)) {
            return CategoryItem(
              categoryName: category.categoryName,
              items: filteredItems,
            );
          }
          return null; // Exclude categories with no matching items or category name
        })
        .where((category) => category != null)
        .cast<CategoryItem>()
        .toList(); // Filter out nulls

    setState(() {
      _filteredData = filtered;
    });
    print('Filtered data count: ${_filteredData.length}'); // Debug print
  }

  // Show the dropdown overlay
  void _showDropdown() {
    if (_overlayEntry != null) return; // Avoid showing multiple overlays

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
    print('Dropdown shown'); // Debug print
  }

  // Hide the dropdown overlay
  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
    print('Dropdown hidden'); // Debug print
  }

  // Create the overlay entry for the dropdown list
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset:
              Offset(0.0, size.height + 5.0), // Position below the input field
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              constraints:
                  BoxConstraints(maxHeight: 200), // Max height for scroll
              child: _buildDropdownList(),
            ),
          ),
        ),
      ),
    );
  }

  // Build the dropdown list content
  Widget _buildDropdownList() {
    print(
        '_buildDropdownList called. _filteredData count: ${_filteredData.length}'); // Debug print
    if (_filteredData.isEmpty && _searchController.text.isNotEmpty) {
      return Container(
        color: Colors.red.shade50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ':( لا توجد نتائج',
              style: TextStyle(color: redmain),
            ),
          ),
        ),
      );
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: cyan400, borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: _filteredData.length,
        itemBuilder: (context, categoryIndex) {
          final category = _filteredData[categoryIndex];
          // Only show ExpansionTile if the category has items after filtering
          if (category.items.isEmpty &&
              !_searchController.text
                  .toLowerCase()
                  .contains(category.categoryName.toLowerCase())) {
            return SizedBox
                .shrink(); // Hide empty categories unless category name matches filter
          }
          return ExpansionTile(
            backgroundColor: cyan500,
            title: Text(
              category.categoryName,
              style: TextStyle(color: cyan50),
            ),
            children: category.items.map((item) {
              return ListTile(
                title: Text(
                  item,
                  style: TextStyle(color: cyan50),
                ),
                onTap: () {
                  _selectItem(item);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // Handle item selection
  void _selectItem(String item) {
    setState(() {
      _selectedItem = item;
      _searchController.text = item; // Set the selected item in the text field
      _searchController.selection = TextSelection.fromPosition(TextPosition(
          offset: _searchController.text.length)); // Place cursor at the end
    });
    _hideDropdown(); // Hide the dropdown after selection
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedItem);
    }
    print('Item selected: $item'); // Debug print
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cyan200),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: cyan300),
            borderRadius: BorderRadius.circular(20.0),
          ),
          suffixIcon: _isDropdownOpen
              ? IconButton(
                  icon: Icon(Icons.arrow_drop_up),
                  onPressed: _hideDropdown,
                )
              : IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: _showDropdown,
                ),
        ),
        onTap: () {
          // Show dropdown when the text field is tapped, but only if it's not already open
          if (!_isDropdownOpen) {
            _showDropdown();
          }
        },
        // Prevent keyboard from hiding the dropdown immediately on tap
        readOnly: false, // Keep readOnly as false to allow typing
      ),
    );
  }
}
