// 2. SearchBar actualizado con funcionalidad
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/home/providers/event_providers.dart';

import '../../features/home/providers/category_providers.dart';

class SearchBarDesign extends ConsumerStatefulWidget {
  final bool filter;
  const SearchBarDesign({super.key, required this.filter});

  @override
  ConsumerState<SearchBarDesign> createState() => _SearchBarDesignState();
}

class _SearchBarDesignState extends ConsumerState<SearchBarDesign> {
  late TextEditingController _controller;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // Cargar el texto de búsqueda actual si existe
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentQuery = ref.read(searchQueryProvider);
      if (currentQuery.isNotEmpty) {
        _controller.text = currentQuery;
        _isSearching = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    setState(() {
      _isSearching = false;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);

    return Row(children: [
      // Campo de texto con diseño redondeado y sin borde
      Expanded(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _controller,
            style: AppTypography.body1,
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).state = value;
              setState(() {
                _isSearching = value.isNotEmpty;
              });
            },
            onTap: () {
              setState(() {
                _isSearching = true;
              });
            },
            decoration: InputDecoration(
              hintText: "Busca tu evento favorito...",
              hintStyle:
                  AppTypography.body2.copyWith(color: AppColors.neutral400),
              prefixIcon: _isSearching
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: SvgPicture.asset(
                        "assets/images/search.svg",
                        width: 24,
                        height: 24,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                          AppColors.neutral400,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.neutral500,
                        size: 20,
                      ),
                      onPressed: _clearSearch,
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 40, minHeight: 40),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColors.primary300,
                  width: 1,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),

      if (widget.filter)
        GestureDetector(
          onTap: () {
            // Aquí puedes abrir un modal de filtros avanzados
            _showFilterBottomSheet(context);
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/filter.svg",
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  AppColors.neutral600,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        )
      else
        const SizedBox.shrink(),
    ]);
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(),
    );
  }
}

// 3. Bottom Sheet para filtros avanzados (opcional)
class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTag = ref.watch(selectedTagProvider);
    final categories = ref.watch(getAllCategoriesProvider);
    ref.watch(searchQueryProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: AppColors.neutral300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categorías
                AppText.body1("Categorías", color: AppColors.neutral900),
                const SizedBox(height: 12),

                categories.when(
                  data: (list) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildFilterChip(
                        "Todas",
                        selectedTag == null,
                        () =>
                            ref.read(selectedTagProvider.notifier).state = null,
                      ),
                      ...list.map((category) => _buildFilterChip(
                            category.name,
                            selectedTag == category.name,
                            () => ref.read(selectedTagProvider.notifier).state =
                                category.name,
                          )),
                    ],
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),

                const SizedBox(height: 20),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Aplicar filtros"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: AppText.caption(
          label,
          color: isSelected ? Colors.white : AppColors.neutral700,
        ),
        backgroundColor: isSelected ? AppColors.primary500 : Colors.white,
        side: BorderSide(
          color: isSelected ? AppColors.primary500 : AppColors.neutral400,
        ),
      ),
    );
  }
}
