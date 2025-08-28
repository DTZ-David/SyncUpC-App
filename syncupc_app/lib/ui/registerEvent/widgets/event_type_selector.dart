import '../../../design_system/models/dropdown_item.dart';
import '../../../design_system/molecules/drop_down.dart';
import '../../../features/home/models/category_request.dart';
import '../../../features/home/providers/category_providers.dart';
import '../../../features/registerEvent/models/event_type_request.dart';
import '../../../features/registerEvent/providers/event_providers.dart';
import 'register_event_exports.dart';

class EventTypeSelector extends ConsumerWidget {
  final List<String> selectedEventTypes;
  final List<String> selectedEventCategories;
  final Function(List<String>) onEventTypesChanged;
  final Function(List<String>) onEventCategoriesChanged;

  const EventTypeSelector({
    super.key,
    required this.selectedEventTypes,
    required this.selectedEventCategories,
    required this.onEventTypesChanged,
    required this.onEventCategoriesChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventTypesAsync = ref.watch(getAllEventTypesProvider);
    final eventCategoriesAsync = ref.watch(getAllCategoriesProvider);

    return Column(
      children: [
        // Selector de Tipos de Evento
        _buildEventTypesSection(eventTypesAsync),

        const SizedBox(height: 16),

        // Selector de Categorías
        _buildEventCategoriesSection(eventCategoriesAsync),
      ],
    );
  }

  Widget _buildEventTypesSection(
      AsyncValue<List<EventTypeRequest>> eventTypesAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle("Tipos de Evento"),

        // Dropdown para seleccionar tipos
        eventTypesAsync.when(
          data: (eventTypes) {
            // Filtrar tipos que no han sido seleccionados
            final availableTypes = eventTypes
                .where((type) => !selectedEventTypes.contains(type.id))
                .toList();

            if (availableTypes.isEmpty && selectedEventTypes.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.neutral300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppText.body2(
                          "Todos los tipos disponibles han sido seleccionados",
                          color: AppColors.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final dropdownItems = availableTypes.map((type) {
              return DropdownItem<String>(
                value: type.id,
                title: type.name,
              );
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(12),
              child: DropdownMolecule<String>(
                labelText: 'Tipos de Evento',
                hintText: selectedEventTypes.isEmpty
                    ? 'Selecciona los tipos de evento'
                    : 'Agregar otro tipo',
                isRequired: selectedEventTypes.isEmpty,
                selectedValue:
                    null, // Siempre null para permitir selecciones múltiples
                items: dropdownItems,
                onChanged: (selectedType) {
                  if (selectedType != null) {
                    _addEventType(selectedType);
                  }
                },
                errorText: selectedEventTypes.isEmpty
                    ? "Debe seleccionar al menos un tipo"
                    : null,
              ),
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Padding(
            padding: const EdgeInsets.all(12),
            child: AppText.body2(
              'Error al cargar tipos de evento: $error',
              color: Colors.red,
            ),
          ),
        ),

        // Lista de tipos seleccionados
        if (selectedEventTypes.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AppText.body2(
              "Tipos seleccionados:",
              color: AppColors.neutral700,
            ),
          ),
          const SizedBox(height: 8),
          ...selectedEventTypes.map((typeId) {
            return eventTypesAsync.when(
              data: (eventTypes) {
                final type = eventTypes.firstWhere((t) => t.id == typeId);
                return _SelectedItemChip(
                  title: type.name,
                  onRemove: () => _removeEventType(typeId),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildEventCategoriesSection(
      AsyncValue<List<EventCategoryRequest>> eventCategoriesAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle("Categorías del Evento"),

        // Dropdown para seleccionar categorías
        eventCategoriesAsync.when(
          data: (eventCategories) {
            // Filtrar categorías que no han sido seleccionadas
            final availableCategories = eventCategories
                .where((category) =>
                    !selectedEventCategories.contains(category.id))
                .toList();

            if (availableCategories.isEmpty &&
                selectedEventCategories.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.neutral300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppText.body2(
                          "Todas las categorías disponibles han sido seleccionadas",
                          color: AppColors.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final dropdownItems = availableCategories.map((category) {
              return DropdownItem<String>(
                value: category.id,
                title: category.name,
              );
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(12),
              child: DropdownMolecule<String>(
                labelText: 'Categorías del Evento',
                hintText: selectedEventCategories.isEmpty
                    ? 'Selecciona las categorías'
                    : 'Agregar otra categoría',
                isRequired: selectedEventCategories.isEmpty,
                selectedValue:
                    null, // Siempre null para permitir selecciones múltiples
                items: dropdownItems,
                onChanged: (selectedCategory) {
                  if (selectedCategory != null) {
                    _addEventCategory(selectedCategory);
                  }
                },
                errorText: selectedEventCategories.isEmpty
                    ? "Debe seleccionar al menos una categoría"
                    : null,
              ),
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Padding(
            padding: const EdgeInsets.all(12),
            child: AppText.body2(
              'Error al cargar categorías: $error',
              color: Colors.red,
            ),
          ),
        ),

        // Lista de categorías seleccionadas
        if (selectedEventCategories.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AppText.body2(
              "Categorías seleccionadas:",
              color: AppColors.neutral700,
            ),
          ),
          const SizedBox(height: 8),
          ...selectedEventCategories.map((categoryId) {
            return eventCategoriesAsync.when(
              data: (eventCategories) {
                final category =
                    eventCategories.firstWhere((c) => c.id == categoryId);
                return _SelectedItemChip(
                  title: category.name,
                  onRemove: () => _removeEventCategory(categoryId),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            );
          }),
        ],
      ],
    );
  }

  void _addEventType(String typeId) {
    if (!selectedEventTypes.contains(typeId)) {
      final updatedTypes = [...selectedEventTypes, typeId];
      onEventTypesChanged(updatedTypes);
    }
  }

  void _removeEventType(String typeId) {
    final updatedTypes =
        selectedEventTypes.where((id) => id != typeId).toList();
    onEventTypesChanged(updatedTypes);
  }

  void _addEventCategory(String categoryId) {
    if (!selectedEventCategories.contains(categoryId)) {
      final updatedCategories = [...selectedEventCategories, categoryId];
      onEventCategoriesChanged(updatedCategories);
    }
  }

  void _removeEventCategory(String categoryId) {
    final updatedCategories =
        selectedEventCategories.where((id) => id != categoryId).toList();
    onEventCategoriesChanged(updatedCategories);
  }
}

// Componente para mostrar items seleccionados como chips removibles
class _SelectedItemChip extends StatelessWidget {
  final String title;
  final VoidCallback onRemove;

  const _SelectedItemChip({
    required this.title,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary200),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.primary600,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText.body2(
                title,
                color: AppColors.primary700,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.primary200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.close,
                  color: AppColors.primary700,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
