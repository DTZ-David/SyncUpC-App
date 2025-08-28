import '../../../design_system/models/dropdown_item.dart';
import '../../../design_system/molecules/drop_down.dart';
import '../../../features/registerEvent/models/event_campus_request.dart';
import '../../../features/registerEvent/models/event_space_request.dart';
import '../../../features/registerEvent/providers/event_providers.dart';
import 'register_event_exports.dart';

class EventLocationSelector extends ConsumerWidget {
  final String? selectedCampusId;
  final String? selectedSpaceId;
  final Function(String?) onCampusChanged;
  final Function(String?) onSpaceChanged;

  const EventLocationSelector({
    super.key,
    required this.selectedCampusId,
    required this.selectedSpaceId,
    required this.onCampusChanged,
    required this.onSpaceChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campusAsync = ref.watch(getAllCampusesProvider);
    final spaceAsync = ref.watch(getAllSpacesProvider);

    return Column(
      children: [
        // Selector de Campus
        SectionTitle("Campus"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: _buildCampusDropdown(campusAsync),
        ),

        // Selector de Espacio (solo si hay campus seleccionado)
        if (selectedCampusId != null && selectedCampusId!.isNotEmpty) ...[
          SectionTitle("Espacio"),
          Padding(
            padding: const EdgeInsets.all(12),
            child: _buildSpaceDropdown(spaceAsync),
          ),
        ],
      ],
    );
  }

  Widget _buildCampusDropdown(
      AsyncValue<List<EventCampusRequest>> campusAsync) {
    return campusAsync.when(
      data: (campusList) {
        final items = campusList
            .map(
              (campus) => DropdownItem(
                value: campus.id,
                title: campus.name,
              ),
            )
            .toList();

        return DropdownMolecule<String>(
          labelText: 'Campus',
          hintText: 'Selecciona un campus',
          isRequired: true,
          selectedValue: selectedCampusId,
          items: items,
          onChanged: (value) {
            onCampusChanged(value);
            // Limpiar selección de espacio cuando cambia el campus
            if (selectedSpaceId != null) {
              onSpaceChanged(null);
            }
          },
        );
      },
      loading: () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => AppText.body2(
        'Error al cargar campus: $error',
        color: Colors.red,
      ),
    );
  }

  Widget _buildSpaceDropdown(AsyncValue<List<EventSpaceRequest>> spaceAsync) {
    return spaceAsync.when(
      data: (spacesList) {
        // Filtrar espacios por campus seleccionado
        final filteredSpaces = spacesList
            .where((space) => space.campusId == selectedCampusId)
            .toList();

        final items = filteredSpaces
            .map(
              (space) => DropdownItem(
                value: space.id,
                title: space.name,
              ),
            )
            .toList();

        return DropdownMolecule<String>(
          labelText: 'Espacio',
          hintText: 'Selecciona un espacio',
          isRequired: true,
          selectedValue: selectedSpaceId,
          items: items,
          onChanged: onSpaceChanged,
        );
      },
      loading: () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => AppText.body2(
        'Error al cargar espacios: $error',
        color: Colors.red,
      ),
    );
  }
}
