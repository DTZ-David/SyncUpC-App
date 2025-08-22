import 'package:go_router/go_router.dart';
import 'package:syncupc/features/registerEvent/controllers/register_event_controller.dart';
import 'package:syncupc/utils/loading_screens/loading_screen.dart';
import 'package:syncupc/utils/popup_utils.dart';
import '../../../features/auth/models/register_state.dart';
import '../../../features/home/providers/event_providers.dart';
import '../widgets/register_event_exports.dart';
import '../widgets/register_event_form_builder.dart';
import '../widgets/register_event_service.dart';
import '../widgets/register_event_validator.dart';

class RegisterEventScreen extends ConsumerStatefulWidget {
  const RegisterEventScreen({super.key});

  @override
  ConsumerState<RegisterEventScreen> createState() =>
      _RegisterEventScreenState();
}

class _RegisterEventScreenState extends ConsumerState<RegisterEventScreen> {
  // Controllers y estado del formulario
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
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

  late final RegisterEventFormBuilder _formBuilder;
  late final RegisterEventValidator _validator;
  late final RegisterEventService _service;

  @override
  void initState() {
    super.initState();
    _formBuilder = RegisterEventFormBuilder();
    _validator = RegisterEventValidator();
    _service = RegisterEventService();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _linkController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final permissions = ref.watch(permissionProvider);

    _setupStateListener();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _formBuilder.buildFormSections(
              context: context,
              titleController: _titleController,
              locationController: _locationController,
              addressController: _addressController,
              linkController: _linkController,
              descriptionController: _descriptionController,
              selectedImage: _selectedImage,
              selectedCareers: _selectedCareers,
              selectedDate: _selectedDate,
              startTime: _startTime,
              endTime: _endTime,
              isVirtual: _isVirtual,
              requiresRegistration: _requiresRegistration,
              allowProfessors: _allowProfessors,
              allowStudents: _allowStudents,
              allowGraduates: _allowGraduates,
              allowGeneralPublic: _allowGeneralPublic,
              permissions: permissions,
              onImageSelected: (image) =>
                  setState(() => _selectedImage = image),
              onCareersChanged: (careers) =>
                  setState(() => _selectedCareers = careers),
              onDateChanged: (date) => setState(() => _selectedDate = date),
              onStartTimeChanged: (time) => setState(() => _startTime = time),
              onEndTimeChanged: (time) => setState(() => _endTime = time),
              onVirtualChanged: (value) => setState(() => _isVirtual = value),
              onRegistrationChanged: (value) =>
                  setState(() => _requiresRegistration = value),
              onProfessorsChanged: (value) =>
                  setState(() => _allowProfessors = value),
              onStudentsChanged: (value) =>
                  setState(() => _allowStudents = value),
              onGraduatesChanged: (value) =>
                  setState(() => _allowGraduates = value),
              onGeneralPublicChanged: (value) =>
                  setState(() => _allowGeneralPublic = value),
              onCreateEvent: _createEvent,
              ref: ref,
            ),
          ),
        ),
      ),
    );
  }

  void _setupStateListener() {
    ref.listen<RegisterState>(registerEventControllerProvider,
        (previous, next) {
      // Si cambió a loading, mostrar loading
      if (next.isLoading && !previous!.isLoading) {
        context.showLoadingDialog(type: LoadingType.simple);
      }

      // Si ya no está loading, ocultar loading
      if (!next.isLoading && previous!.isLoading) {
        context.hideLoadingDialog();
      }

      // Si fue exitoso, navegar
      if (next.isSuccess && !previous!.isSuccess) {
        _showSuccessAndNavigate();
      }

      // Si hay error, mostrarlo
      if (next.errorMessage != null &&
          next.errorMessage != previous!.errorMessage) {
        _showError(next.errorMessage!);
      }
    });
  }

  Future<void> _createEvent() async {
    if (!_validator.validateForm(
      context: context,
      titleController: _titleController,
      descriptionController: _descriptionController,
      selectedDate: _selectedDate,
      startTime: _startTime,
      endTime: _endTime,
      selectedCareers: _selectedCareers,
      allowProfessors: _allowProfessors,
      allowStudents: _allowStudents,
      allowGraduates: _allowGraduates,
      allowGeneralPublic: _allowGeneralPublic,
      isVirtual: _isVirtual,
      linkController: _linkController,
    )) return;

    await _service.createEvent(
      context: context,
      ref: ref,
      titleController: _titleController,
      locationController: _locationController,
      addressController: _addressController,
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
    );
  }

  void _showSuccessAndNavigate() {
    PopupUtils.showSuccess(
      context,
      message: '¡Evento creado exitosamente!',
      subtitle: 'Tu evento ha sido registrado correctamente',
      duration: const Duration(seconds: 2),
    );

    ref.read(registerEventControllerProvider.notifier).resetSuccess();
    ref.invalidate(getAllEventsForUProvider);
    ref.invalidate(getAllEventsProvider);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.go('/');
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

    // Limpiar el error después de mostrarlo
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        ref.read(registerEventControllerProvider.notifier).clearError();
      }
    });
  }
}
