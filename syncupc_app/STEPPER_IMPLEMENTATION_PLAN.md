# Plan de Implementación del Stepper para Registro de Eventos

## Problema Actual
- El formulario de registro de eventos es muy extenso (todas las secciones en una sola pantalla)
- Performance lenta debido a demasiados widgets renderizándose al mismo tiempo
- Experiencia de usuario abrumadora

## Solución: Sistema de Stepper (4 Pasos)

### Paso 1: Información Básica
**Campos:**
- Imagen del evento (opcional)
- Título del evento *
- Descripción *

**Validación:**
- Título no vacío
- Descripción no vacía

### Paso 2: Ubicación y Tipo
**Campos:**
- Campus *
- Espacio *
- Tipos de Evento * (multi-select)
- Categorías * (multi-select)

**Validación:**
- Campus seleccionado
- Espacio seleccionado
- Al menos un tipo seleccionado
- Al menos una categoría seleccionada

### Paso 3: Detalles del Evento
**Campos:**
- Carreras dirigidas * (multi-select)
- Audiencia * (checkboxes: Profesores, Estudiantes, Graduados, Público General)
- ¿Es virtual? (switch)
  - Si es virtual: Link de evento *
- ¿Requiere registro? (switch)
- Capacidad máxima (número, 0 = ilimitado)
- ¿Es público? (switch)

**Validación:**
- Al menos una carrera seleccionada
- Al menos un tipo de audiencia seleccionado
- Si es virtual, link no vacío

### Paso 4: Fecha y Hora
**Campos:**
- Fecha del evento *
- Hora de inicio *
- Hora de fin *

**Validación:**
- Fecha seleccionada
- Fecha no en el pasado
- Hora de inicio y fin seleccionadas
- Hora de fin posterior a hora de inicio

**Botón:** "Crear Evento" (en lugar de "Siguiente")

---

## Archivos Creados

### 1. `/lib/ui/registerEvent/models/event_form_step.dart`
Enum que define los 4 pasos del formulario con títulos y números.

### 2. `/lib/ui/registerEvent/widgets/event_form_stepper.dart`
Widget visual que muestra el progreso con círculos numerados y líneas conectoras.

### 3. Widgets de Pasos (usar componentes existentes)
Reutilizar los componentes ya creados:
- `EventImagePicker` - Para la imagen
- `EventLocationSelector` - Para campus y espacio
- `EventTypeSelector` - Para tipos y categorías
- `EventBasicInfoForm` - Adaptar para solo título y descripción
- `MultiCareerSelection` - Para selección de carreras
- `EventAudienceSelector` - Para audiencia
- `EventDateTimePicker` - Para fecha y hora

---

## Implementación del Screen Principal

```dart
class RegisterEventScreen extends ConsumerStatefulWidget {
  // Estado actual
  EventFormStep _currentStep = EventFormStep.basicInfo;

  // Métodos
  void _nextStep() {
    if (_validateCurrentStep()) {
      setState(() {
        _currentStep = EventFormStep.values[_currentStep.index + 1];
      });
    }
  }

  void _previousStep() {
    if (_currentStep.index > 0) {
      setState(() {
        _currentStep = EventFormStep.values[_currentStep.index - 1];
      });
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case EventFormStep.basicInfo:
        return _validateBasicInfo();
      case EventFormStep.locationAndType:
        return _validateLocationAndType();
      case EventFormStep.details:
        return _validateDetails();
      case EventFormStep.dateTime:
        return _validateDateTime();
    }
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case EventFormStep.basicInfo:
        return _buildBasicInfoStep();
      case EventFormStep.locationAndType:
        return _buildLocationTypeStep();
      case EventFormStep.details:
        return _buildDetailsStep();
      case EventFormStep.dateTime:
        return _buildDateTimeStep();
    }
  }
}
```

---

## Beneficios

1. **Performance Mejorada**: Solo se renderizan los widgets del paso actual
2. **Mejor UX**: Usuario se enfoca en un conjunto pequeño de campos a la vez
3. **Validación por Pasos**: Feedback inmediato al intentar avanzar
4. **Progreso Visual**: Indicador claro de cuánto falta
5. **Navegación Flexible**: Puede retroceder para editar información

---

## Próximos Pasos de Implementación

1. ✅ Crear modelo `EventFormStep`
2. ✅ Crear widget visual `EventFormStepper`
3. 🔄 Refactorizar `RegisterEventScreen`:
   - Agregar estado `_currentStep`
   - Implementar `_buildCurrentStepContent()`
   - Implementar validaciones por paso
   - Agregar botones "Anterior" y "Siguiente"
4. ⏳ Adaptar validador para trabajar por pasos
5. ⏳ Probar flujo completo
6. ⏳ Ajustar padding y espaciado

---

## Notas Importantes

- Los datos del formulario se mantienen en el estado del screen principal
- Solo cambia el paso visual, no se pierden datos al navegar entre pasos
- El botón "Crear Evento" solo aparece en el último paso
- Se puede retroceder a cualquier paso anterior para editar
