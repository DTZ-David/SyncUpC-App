// ============================================================================
// WIDGET PARA SELECCIÓN MÚLTIPLE DE CARRERAS
// ============================================================================

import '../../../design_system/molecules/drop_down.dart';
import '../../../features/auth/providers/career_provider.dart';
import '../../../design_system/models/dropdown_item.dart';
import 'register_event_exports.dart';
import 'selected_career_chip.dart';

class MultiCareerSelector extends ConsumerWidget {
  final List<String> selectedCareers;
  final Function(List<String>) onCareersChanged;

  const MultiCareerSelector({
    super.key,
    required this.selectedCareers,
    required this.onCareersChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final careersAsync = ref.watch(getAllCareersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle("A quien va dirigido?"),

        // Dropdown para seleccionar carreras
        careersAsync.when(
          data: (careers) {
            // Filtrar carreras que no han sido seleccionadas
            final availableCareers = careers
                .where((career) => !selectedCareers.contains(career.id))
                .toList();

            if (availableCareers.isEmpty && selectedCareers.isNotEmpty) {
              // Si no hay carreras disponibles y ya se seleccionaron algunas
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Todas las carreras disponibles han sido seleccionadas",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final dropdownItems = availableCareers.map((career) {
              return DropdownItem<String>(
                value: career.id,
                title: career.name,
                subtitle: null,
              );
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(12),
              child: DropdownMolecule<String>(
                hintText: selectedCareers.isEmpty
                    ? 'Selecciona las carreras'
                    : 'Agregar otra carrera',
                isRequired: selectedCareers.isEmpty,
                selectedValue:
                    null, // Siempre null para permitir selecciones múltiples
                items: dropdownItems,
                onChanged: (selectedCareer) {
                  if (selectedCareer != null) {
                    _addCareer(selectedCareer);
                  }
                },
              ),
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Error cargando carreras. Intenta nuevamente.',
                      style: TextStyle(color: Colors.red.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Lista de carreras seleccionadas
        if (selectedCareers.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Carreras seleccionadas:",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...selectedCareers.map((careerId) {
            return careersAsync.when(
              data: (careers) {
                final career = careers.firstWhere(
                  (c) => c.id == careerId,
                );

                return SelectedCareerChip(
                  career: career,
                  onRemove: () => _removeCareer(careerId),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            );
          })
        ],
      ],
    );
  }

  void _addCareer(String careerId) {
    if (!selectedCareers.contains(careerId)) {
      final updatedCareers = [...selectedCareers, careerId];
      onCareersChanged(updatedCareers);
    }
  }

  void _removeCareer(String careerId) {
    final updatedCareers =
        selectedCareers.where((id) => id != careerId).toList();
    onCareersChanged(updatedCareers);
  }
}
