import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final void Function(String? searchText) onSearchTextChanged;
  final List<String> items;
  final String? label;
  final String? item;
  const SearchableDropdown({
    super.key,
    this.item,
    this.label,
    required this.onSearchTextChanged,
    required this.items,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.item ?? '';
  }

  @override
  void didUpdateWidget(covariant SearchableDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _searchController.text = widget.item ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.label,
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      readOnly: true,
      onTap: () async {
        final item = await Navigator.push(
          context,
          PageRouteBuilder(
            barrierDismissible: true,
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return Center(
                child: SizedBox(
                  width: 370,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kToolbarHeight,
                    ),
                    child: _SeachItems(
                      items: widget.items,
                      label: widget.label,
                    ),
                  ),
                ),
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );

        if (item is String) {
          widget.onSearchTextChanged(item);
          _searchController.text = item;
        }
      },
    );
  }
}

class _SeachItems extends StatefulWidget {
  final List<String> items;
  final String? label;

  const _SeachItems({required this.items, this.label});

  @override
  State<_SeachItems> createState() => _SeachItemsState();
}

class _SeachItemsState extends State<_SeachItems> {
  var filteredItems = <String>[];
  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void filter(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        filteredItems = widget.items;
      });
      return;
    }

    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 17,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.label,
            ),
            onChanged: filter,
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]),
                    onTap: () {
                      Navigator.pop(context, filteredItems[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
