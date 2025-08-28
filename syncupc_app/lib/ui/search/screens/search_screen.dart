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
  final Set<String> selectedTags = {};

  @override
  Widget build(BuildContext context) {
    ref.watch(getAllCategoriesProvider);

    final allEvents = ref.watch(getAllEventsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header con gradiente
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
                    // Barra de búsqueda mejorada
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
                      child: const SearchBarDesign(filter: false),
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
                child: Consumer(
                  builder: (context, ref, _) {
                    final categories = ref.watch(getAllCategoriesProvider);

                    return categories.when(
                      data: (list) => Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: list
                            .map(
                                (category) => _buildCategoryChip(category.name))
                            .toList(),
                      ),
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
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Mostrar filtros activos si hay alguno
            if (selectedTags.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        "Filtrando por:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedTags.clear();
                          });
                        },
                        icon: const Icon(Icons.clear, size: 16),
                        label: const Text("Limpiar",
                            style: TextStyle(fontSize: 12)),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
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
              sliver: allEvents.when(
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
                  // Filtrar eventos basado en tags seleccionados
                  final filteredEvents = selectedTags.isEmpty
                      ? eventList
                      : eventList.where((event) {
                          // Asume que el evento tiene una propiedad 'tags' o similar
                          // Ajusta esta lógica según tu modelo de datos
                          return selectedTags.any((selectedTag) =>
                              event.eventTitle
                                  .toLowerCase()
                                  .contains(selectedTag.toLowerCase()) ||
                              // Si tienes un campo de tags en el evento, úsalo así:
                              // event.tags.contains(selectedTag)
                              selectedTag.toLowerCase() == 'académicos' &&
                                  event.eventTitle
                                      .toLowerCase()
                                      .contains('académ') ||
                              selectedTag.toLowerCase() == 'charla' &&
                                  event.eventTitle
                                      .toLowerCase()
                                      .contains('charla') ||
                              selectedTag.toLowerCase() == 'motivación' &&
                                  event.eventTitle
                                      .toLowerCase()
                                      .contains('motiva') ||
                              selectedTag.toLowerCase() == 'liderazgo' &&
                                  event.eventTitle
                                      .toLowerCase()
                                      .contains('lider') ||
                              selectedTag.toLowerCase() == 'seminario' &&
                                  event.eventTitle
                                      .toLowerCase()
                                      .contains('seminario') ||
                              selectedTag.toLowerCase() == 'investigación' &&
                                  event.eventTitle
                                      .toLowerCase()
                                      .contains('investiga'));
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
                              selectedTags.isEmpty
                                  ? "No hay eventos disponibles"
                                  : "No se encontraron eventos\ncon las categorías seleccionadas",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (selectedTags.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    selectedTags.clear();
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

  Widget _buildCategoryChip(String tag) {
    final isSelected = selectedTags.contains(tag);

    // Lista de iconos para las categorías
    final categoryIcons = {
      'académicos': Icons.school,
      'charla': Icons.chat,
      'motivación': Icons.psychology,
      'seminario': Icons.event,
      'investigación': Icons.science,
    };

    final categoryColors = {
      'académicos': Colors.blue,
      'charla': Colors.green,
      'motivación': Colors.orange,
      'liderazgo': Colors.purple,
      'seminario': Colors.teal,
      'investigación': Colors.red,
    };

    final icon = categoryIcons[tag.toLowerCase()] ?? Icons.label;
    final color = categoryColors[tag.toLowerCase()] ?? Colors.grey;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: 6),
            Text(
              tag,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
        onSelected: (selected) {
          setState(() {
            if (selected) {
              selectedTags.add(tag);
            } else {
              selectedTags.remove(tag);
            }
          });
        },
        backgroundColor: Colors.white,
        selectedColor: color,
        checkmarkColor: Colors.white,
        elevation: isSelected ? 4 : 2,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? color : color.withOpacity(0.3),
            width: isSelected ? 0 : 1,
          ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                if (event.imageUrls.isNotEmpty)
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
                    event.eventTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Icono de favorito
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red[400],
                      size: 16,
                    ),
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
