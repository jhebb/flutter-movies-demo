import 'package:flutter/material.dart';

import '../colors.dart';
import '../pages/search.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();
  bool _hasSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    setState(() {
      _hasSearch = value.isNotEmpty;
    });
  }

  void _handleClearSearch() {
    _searchController.clear();

    setState(() {
      _hasSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.buttonSecondary), borderRadius: BorderRadius.circular(50)),
              child: TextField(
                onChanged: _handleChanged,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                  hintText: 'Search movies...',
                  border: InputBorder.none,
                  suffixIconConstraints: const BoxConstraints(maxHeight: 18, maxWidth: 18),
                  suffixIcon: _hasSearch
                      ? InkWell(
                          onTap: _handleClearSearch,
                          child: const Icon(
                            Icons.clear,
                            color: AppColors.buttonPrimary,
                            size: 18,
                          ),
                        )
                      : null,
                ),
                controller: _searchController,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ClipOval(
            child: Container(
              color: AppColors.buttonSecondary,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: _hasSearch
                    ? () {
                        print('search for: ${_searchController.text}');

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage(query: _searchController.text)),
                        );
                      }
                    : null,
                icon: const Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
    );
  }
}
