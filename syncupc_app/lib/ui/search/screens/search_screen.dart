import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/molecules/search_bar.dart';
import 'package:syncupc/features/home/providers/event_providers.dart';

import '../../../design_system/protons/colors.dart';
import '../../../features/home/providers/category_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final Set<String> selectedCategoryNames = {};
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Función para asignar colores a las categorías específicas
  Color getCategoryColor(String categoryName) {
    final specificColors = {
      'Académico': Colors.blue,
      'Investigación': Colors.red,
      'Tecnología e innovación': Colors.orange,
      'Cultural y artístico': Colors.purple,
      'Deportivo': Colors.teal,
      'Bienestar y salud': Colors.pink,
      'Social y comunitario': Colors.amber,
      'Otros': Colors.grey,
    };

    return specificColors[categoryName] ?? Colors.indigo;
  }

  // Función para asignar iconos a las categorías específicas
  IconData getCategoryIcon(String categoryName) {
    final specificIcons = {
      'Académico': Icons.school,
      'Investigación': Icons.science,
      'Tecnología e innovación': Icons.computer,
      'Cultural y artístico': Icons.theater_comedy,
      'Deportivo': Icons.sports,
      'Bienestar y salud': Icons.favorite,
      'Social y comunitario': Icons.groups,
      'Otros': Icons.category,
    };

    return specificIcons[categoryName] ?? Icons.label;
  }

  // Función para ordenar las categorías de manera lógica
  List<dynamic> _sortCategories(List<dynamic> categories) {
    final categoryOrder = [
      'Académico',
      'Investigación',
      'Tecnología e innovación',
      'Cultural y artístico',
      'Deportivo',
      'Bienestar y salud',
      'Social y comunitario',
      'Otros',
    ];

    final sortedCategories = <dynamic>[];

    // Primero agregar las categorías en el orden específico
    for (String categoryName in categoryOrder) {
      try {
        final category = categories.firstWhere(
          (cat) => cat.name == categoryName,
        );
        sortedCategories.add(category);
      } catch (e) {
        // La categoría no existe, continuar
      }
    }

    // Agregar cualquier categoría que no esté en el orden específico
    for (var category in categories) {
      if (!sortedCategories.any((cat) => cat.name == category.name)) {
        sortedCategories.add(category);
      }
    }

    return sortedCategories;
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(getAllCategoriesProvider);
    final allEventsAsync = ref.watch(getAllEventsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header con gradiente y barra de búsqueda
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary600,
                      AppColors.primary600.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Saludo personalizado
                    Text(
                      "¡Hola! 👋",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Descubre eventos increíbles",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Barra de búsqueda funcional
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar eventos...',
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      searchController.clear();
                                      searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categorías con diseño mejorado
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.explore,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Explorar categorías",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Chips de categorías para filtrado
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: categoriesAsync.when(
                  data: (categories) {
                    final sortedCategories = _sortCategories(categories);
                    return Container(
                      height: 200, // Altura fija para mostrar ~4 categorías
                      child: ListView.builder(
                        itemCount: sortedCategories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildCategoryChip(
                              sortedCategories[index].name,
                              index,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            "Cargando categorías...",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        "Error al cargar categorías: $e",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Sección de eventos destacados
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.stars,
                      color: Colors.amber[600],
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Eventos destacados",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Grid de eventos mejorado con filtrado
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: allEventsAsync.when(
                loading: () => const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            "Cargando eventos...",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      color: Colors.red[50],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red[400],
                              size: 48,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Error al cargar eventos',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              error.toString(),
                              style: TextStyle(
                                color: Colors.red[600],
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                data: (eventList) {
                  // Filtrar eventos basado en categorías seleccionadas y búsqueda
                  final filteredEvents = eventList.where((event) {
                    bool matchesCategory = selectedCategoryNames.isEmpty ||
                        event.categories.any((category) =>
                            selectedCategoryNames.contains(category.name));

                    bool matchesSearch = searchQuery.isEmpty ||
                        event.eventTitle
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        (event.eventObjective
                                ?.toLowerCase()
                                .contains(searchQuery.toLowerCase()) ??
                            false);

                    return matchesCategory && matchesSearch;
                  }).toList();

                  if (filteredEvents.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              (selectedCategoryNames.isEmpty &&
                                      searchQuery.isEmpty)
                                  ? "No hay eventos disponibles"
                                  : "No se encontraron eventos\ncon los filtros aplicados",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (selectedCategoryNames.isNotEmpty ||
                                searchQuery.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedCategoryNames.clear();
                                    searchController.clear();
                                    searchQuery = '';
                                  });
                                },
                                icon: const Icon(Icons.clear),
                                label: const Text("Limpiar filtros"),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final event = filteredEvents[index];
                        return _buildEventCard(context, event);
                      },
                      childCount:
                          filteredEvents.length > 6 ? 6 : filteredEvents.length,
                    ),
                  );
                },
              ),
            ),

            // Espaciado final
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String categoryName, int index) {
    final isSelected = selectedCategoryNames.contains(categoryName);
    final icon = getCategoryIcon(categoryName);
    final color = getCategoryColor(categoryName);

    return Container(
      width: double.infinity,
      height: 45,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                if (selectedCategoryNames.contains(categoryName)) {
                  selectedCategoryNames.remove(categoryName);
                } else {
                  selectedCategoryNames.add(categoryName);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white.withOpacity(0.2) : color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      icon,
                      size: 14,
                      color: isSelected ? Colors.white : Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      categoryName,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : color.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, dynamic event) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            context.push(
              '/event/details',
              extra: event,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.withOpacity(0.8),
                  Colors.purple.withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Imagen de fondo si existe
                if (event.imageUrls != null && event.imageUrls.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      event.imageUrls.first,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.withOpacity(0.8),
                                Colors.purple.withOpacity(0.8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                // Overlay con gradiente
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                // Contenido
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    event.eventTitle ?? 'Sin título',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
