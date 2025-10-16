import 'package:go_router/go_router.dart';
import 'package:syncupc/features/registerEvent/controllers/register_event_controller.dart';
import 'package:syncupc/utils/loading_screens/loading_screen.dart';
import 'package:syncupc/utils/popup_utils.dart';
import '../../../features/auth/models/register_state.dart';
import '../../../features/home/providers/event_providers.dart';
import '../models/event_form_step.dart';
import '../widgets/event_form_stepper.dart';
import '../widgets/register_event_exports.dart';
import '../widgets/register_event_service.dart';
import '../widgets/steps/step1_basic_info.dart';
import '../widgets/steps/step2_location_type.dart';
import '../widgets/steps/step3_details.dart';
import '../widgets/steps/step4_date_time.dart';

class RegisterEventScreenStepper extends ConsumerStatefulWidget {
  const RegisterEventScreenStepper({super.key});

  @override
  ConsumerState<RegisterEventScreenStepper> createState() =>
      _RegisterEventScreenStepperState();
}

class _RegisterEventScreenStepperState
    extends ConsumerState<RegisterEventScreenStepper> {
  // Estado del stepper
  EventFormStep _currentStep = EventFormStep.basicInfo;

  // Controllers y estado del formulario
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectedImage;
  List<String> _selectedCareers = [];
  DateTime? _selectedDate;
  String? _startTime = '9:00 AM';
  String? _endTime = '10:00 AM';

  bool _isVirtual = false;
  bool _requiresRegistration = false;
  bool _allowProfessors = false;
  bool _allowStudents = false;
  bool _allowGraduates = false;
  bool _allowGeneralPublic = false;

  String? _selectedCampusId;
  String? _selectedSpaceId;
  List<String> _selectedEventTypes = [];
  List<String> _selectedEventCategories = [];
  int? _maxCapacity;
  bool _isPublic = true;

  late final RegisterEventService _service;

  @override
  void initState() {
    super.initState();
    _service = RegisterEventService();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom > 0
        ? MediaQuery.of(context).viewInsets.bottom
        : MediaQuery.of(context).padding.bottom + 80;

    _setupStateListener();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_currentStep.title),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _handleBack(context),
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              EventFormStepper(currentStep: _currentStep),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: _buildCurrentStepContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setupStateListener() {
    ref.listen<RegisterState>(registerEventControllerProvider,
        (previous, next) {
      if (next.isLoading && !previous!.isLoading) {
        context.showLoadingDialog(type: LoadingType.simple);
      }

      if (!next.isLoading && previous!.isLoading) {
        context.hideLoadingDialog();
      }

      if (next.isSuccess && !previous!.isSuccess) {
        _showSuccessAndNavigate();
      }

      if (next.errorMessage != null &&
          next.errorMessage != previous!.errorMessage) {
        _showError(next.errorMessage!);
      }
    });
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case EventFormStep.basicInfo:
        return Step1BasicInfo(
          titleController: _titleController,
          descriptionController: _descriptionController,
          selectedImage: _selectedImage,
          onImageSelected: (image) => setState(() => _selectedImage = image),
          onNext: _handleNextStep,
        );

      case EventFormStep.locationAndType:
        return Step2LocationType(
          selectedCampusId: _selectedCampusId,
          selectedSpaceId: _selectedSpaceId,
          selectedEventTypes: _selectedEventTypes,
          selectedEventCategories: _selectedEventCategories,
          onCampusChanged: (id) => setState(() => _selectedCampusId = id),
          onSpaceChanged: (id) => setState(() => _selectedSpaceId = id),
          onEventTypesChanged: (types) =>
              setState(() => _selectedEventTypes = types),
          onEventCategoriesChanged: (categories) =>
              setState(() => _selectedEventCategories = categories),
          onNext: _handleNextStep,
          onBack: _handlePreviousStep,
        );

      case EventFormStep.details:
        return Step3Details(
          selectedCareers: _selectedCareers,
          allowProfessors: _allowProfessors,
          allowStudents: _allowStudents,
          allowGraduates: _allowGraduates,
          allowGeneralPublic: _allowGeneralPublic,
          isVirtual: _isVirtual,
          linkController: _linkController,
          requiresRegistration: _requiresRegistration,
          maxCapacity: _maxCapacity,
          isPublic: _isPublic,
          onCareersChanged: (careers) =>
              setState(() => _selectedCareers = careers),
          onProfessorsChanged: (value) =>
              setState(() => _allowProfessors = value),
          onStudentsChanged: (value) => setState(() => _allowStudents = value),
          onGraduatesChanged: (value) =>
              setState(() => _allowGraduates = value),
          onGeneralPublicChanged: (value) =>
              setState(() => _allowGeneralPublic = value),
          onVirtualChanged: (value) => setState(() => _isVirtual = value),
          onRegistrationChanged: (value) =>
              setState(() => _requiresRegistration = value),
          onMaxCapacityChanged: (capacity) =>
              setState(() => _maxCapacity = capacity),
          onIsPublicChanged: (isPublic) => setState(() => _isPublic = isPublic),
          onNext: _handleNextStep,
          onBack: _handlePreviousStep,
        );

      case EventFormStep.dateTime:
        return Step4DateTime(
          selectedDate: _selectedDate,
          startTime: _startTime,
          endTime: _endTime,
          onDateChanged: (date) => setState(() => _selectedDate = date),
          onStartTimeChanged: (time) => setState(() => _startTime = time),
          onEndTimeChanged: (time) => setState(() => _endTime = time),
          onBack: _handlePreviousStep,
          onCreate: _createEvent,
          ref: ref,
        );
    }
  }

  void _handleNextStep() {
    if (_validateCurrentStep()) {
      if (_currentStep.index < EventFormStep.values.length - 1) {
        setState(() {
          _currentStep = EventFormStep.values[_currentStep.index + 1];
        });
      }
    }
  }

  void _handlePreviousStep() {
    if (_currentStep.index > 0) {
      setState(() {
        _currentStep = EventFormStep.values[_currentStep.index - 1];
      });
    }
  }

  void _handleBack(BuildContext context) {
    if (_currentStep.index > 0) {
      _handlePreviousStep();
    } else {
      context.pop();
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

  bool _validateBasicInfo() {
    if (_titleController.text.trim().isEmpty) {
      _showValidationError('El título del evento es obligatorio');
      return false;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showValidationError('La descripción del evento es obligatoria');
      return false;
    }
    return true;
  }

  bool _validateLocationAndType() {
    if (_selectedCampusId == null || _selectedCampusId!.isEmpty) {
      _showValidationError('Debe seleccionar un campus');
      return false;
    }
    if (_selectedSpaceId == null || _selectedSpaceId!.isEmpty) {
      _showValidationError('Debe seleccionar un espacio');
      return false;
    }
    if (_selectedEventTypes.isEmpty) {
      _showValidationError('Debe seleccionar al menos un tipo de evento');
      return false;
    }
    if (_selectedEventCategories.isEmpty) {
      _showValidationError('Debe seleccionar al menos una categoría');
      return false;
    }
    return true;
  }

  bool _validateDetails() {
    if (_selectedCareers.isEmpty) {
      _showValidationError('Debe seleccionar al menos una carrera');
      return false;
    }
    if (!_allowProfessors &&
        !_allowStudents &&
        !_allowGraduates &&
        !_allowGeneralPublic) {
      _showValidationError('Debe seleccionar al menos un tipo de audiencia');
      return false;
    }
    if (_isVirtual && _linkController.text.trim().isEmpty) {
      _showValidationError('Debe proporcionar un enlace para eventos virtuales');
      return false;
    }
    return true;
  }

  bool _validateDateTime() {
    if (_selectedDate == null) {
      _showValidationError('Debe seleccionar una fecha para el evento');
      return false;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day);

    if (eventDate.isBefore(today)) {
      _showValidationError('La fecha del evento no puede ser en el pasado');
      return false;
    }

    if (_startTime == null || _endTime == null) {
      _showValidationError('Debe seleccionar hora de inicio y fin');
      return false;
    }

    if (!_isEndTimeValid(_startTime!, _endTime!)) {
      _showValidationError('La hora de fin debe ser posterior a la hora de inicio');
      return false;
    }

    return true;
  }

  bool _isEndTimeValid(String startTime, String endTime) {
    final startHour = _convertTo24Hour(startTime);
    final endHour = _convertTo24Hour(endTime);
    return endHour > startHour;
  }

  int _convertTo24Hour(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    final hour = int.parse(timeParts[0]);
    final isPM = parts[1] == 'PM';

    if (isPM && hour != 12) {
      return hour + 12;
    } else if (!isPM && hour == 12) {
      return 0;
    }
    return hour;
  }

  void _showValidationError(String message) {
    PopupUtils.showError(
      context,
      message: message,
      subtitle: 'Por favor completa este campo',
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> _createEvent() async {
    if (!_validateDateTime()) return;

    await _service.createEvent(
      context: context,
      ref: ref,
      titleController: _titleController,
      linkController: _linkController,
      descriptionController: _descriptionController,
      selectedImage: _selectedImage,
      selectedCareers: _selectedCareers,
      selectedDate: _selectedDate!,
      startTime: _startTime!,
      endTime: _endTime!,
      isVirtual: _isVirtual,
      requiresRegistration: _requiresRegistration,
      allowProfessors: _allowProfessors,
      allowStudents: _allowStudents,
      allowGraduates: _allowGraduates,
      allowGeneralPublic: _allowGeneralPublic,
      selectedCampusId: _selectedCampusId!,
      selectedSpaceId: _selectedSpaceId!,
      selectedEventTypes: _selectedEventTypes,
      selectedEventCategories: _selectedEventCategories,
      maxCapacity: _maxCapacity,
      isPublic: _isPublic,
    );
  }

  void _showSuccessAndNavigate() {
    ref.read(registerEventControllerProvider.notifier).resetSuccess();
    ref.invalidate(getAllEventsForUProvider);
    ref.invalidate(getAllEventsProvider);

    context.go('/');

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        PopupUtils.showSuccess(
          context,
          message: '¡Evento creado exitosamente!',
          subtitle: 'Tu evento ha sido registrado correctamente',
          duration: const Duration(seconds: 2),
        );
      }
    });
  }

  void _showError(String message) {
    PopupUtils.showError(
      context,
      message: message,
      subtitle: 'Por favor revisa la información ingresada',
      duration: const Duration(seconds: 3),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        ref.read(registerEventControllerProvider.notifier).clearError();
      }
    });
  }
}
