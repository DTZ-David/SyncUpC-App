import 'package:go_router/go_router.dart';
import 'package:syncupc/features/auth/controllers/register_event_controller.dart';
import 'package:syncupc/features/auth/models/event_request.dart';
import 'package:syncupc/utils/loading_screens/loading_screen.dart';
import '../../../features/auth/models/register_state.dart';
import '../../../utils/upload_image.dart';
import '../widgets/event_audience_selector.dart';
import '../widgets/event_basic_info_form.dart';
import '../widgets/event_date_time_picker.dart';
import '../widgets/event_image_picker.dart';
import '../widgets/event_permissions_section.dart';
import '../widgets/register_event_exports.dart';

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

    // Escuchar cambios en el estado del registro
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
              child: AppText.heading1("Registro de eventos"),
            ),

            // Imagen del evento
            EventImagePicker(
              selectedImage: _selectedImage,
              onImageSelected: (image) =>
                  setState(() => _selectedImage = image),
            ),

            // Información básica
            EventBasicInfoForm(
              titleController: _titleController,
              locationController: _locationController,
              addressController: _addressController,
              linkController: _linkController,
              descriptionController: _descriptionController,
              selectedCareers: _selectedCareers,
              onCareersChanged: (careers) =>
                  setState(() => _selectedCareers = careers),
              isVirtual: _isVirtual,
              onVirtualChanged: (value) => setState(() => _isVirtual = value),
              requiresRegistration: _requiresRegistration,
              onRegistrationChanged: (value) =>
                  setState(() => _requiresRegistration = value),
            ),

            // Selector de audiencia
            EventAudienceSelector(
              allowProfessors: _allowProfessors,
              allowStudents: _allowStudents,
              allowGraduates: _allowGraduates,
              allowGeneralPublic: _allowGeneralPublic,
              onProfessorsChanged: (value) =>
                  setState(() => _allowProfessors = value),
              onStudentsChanged: (value) =>
                  setState(() => _allowStudents = value),
              onGraduatesChanged: (value) =>
                  setState(() => _allowGraduates = value),
              onGeneralPublicChanged: (value) =>
                  setState(() => _allowGeneralPublic = value),
            ),

            // Fecha y hora
            EventDateTimePicker(
              selectedDate: _selectedDate,
              startTime: _startTime,
              endTime: _endTime,
              onDateChanged: (date) => setState(() => _selectedDate = date),
              onStartTimeChanged: (time) => setState(() => _startTime = time),
              onEndTimeChanged: (time) => setState(() => _endTime = time),
            ),

            // Permisos
            EventPermissionsSection(
              permissions: permissions,
            ),

            // Botón de crear evento
            Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer(
                builder: (context, ref, child) {
                  final registerState =
                      ref.watch(registerEventControllerProvider);

                  return PrimaryButton(
                    text:
                        registerState.isLoading ? "Creando..." : "Crear Evento",
                    variant: ButtonVariant.filled,
                    onPressed: registerState.isLoading ? null : _createEvent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime _combineDateAndTime(DateTime date, String time) {
    final timeParts = time.split(RegExp(r'[:\s]'));
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    final isPM = timeParts[2].toLowerCase() == 'pm';

    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  bool _validateForm() {
    if (_titleController.text.trim().isEmpty) {
      _showError('El título del evento es obligatorio');
      return false;
    }

    if (_descriptionController.text.trim().isEmpty) {
      _showError('La descripción del evento es obligatoria');
      return false;
    }

    if (_selectedDate == null) {
      _showError('Selecciona la fecha del evento');
      return false;
    }

    if (_startTime == null || _endTime == null) {
      _showError('Selecciona la hora de inicio y fin del evento');
      return false;
    }

    if (_selectedCareers.isEmpty) {
      _showError('Selecciona al menos una carrera');
      return false;
    }

    if (!_allowProfessors &&
        !_allowStudents &&
        !_allowGraduates &&
        !_allowGeneralPublic) {
      _showError('Selecciona al menos un tipo de público');
      return false;
    }

    if (_isVirtual && _linkController.text.trim().isEmpty) {
      _showError('El enlace es obligatorio para eventos virtuales');
      return false;
    }

    return true;
  }

  void _createEvent() async {
    if (!_validateForm()) return;

    final startDateTime = _combineDateAndTime(_selectedDate!, _startTime!);
    final endDateTime = _combineDateAndTime(_selectedDate!, _endTime!);

    if (endDateTime.isBefore(startDateTime) ||
        endDateTime.isAtSameMomentAs(startDateTime)) {
      _showError('La hora de fin debe ser después de la hora de inicio');
      return;
    }

    List<String> imageUrls = [];

    if (_selectedImage != null) {
      final storageService = SupabaseStorageService();
      final path = 'event_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final imageUrl = await storageService.uploadImage(
        file: _selectedImage!,
        bucket: 'eventpictures',
        path: path,
      );

      if (imageUrl != null) {
        imageUrls.add(imageUrl);
      } else {
        _showError('No se pudo subir la imagen del evento');
        return;
      }
    }

    final eventRequest = EventRequest(
      eventTitle: _titleController.text.trim(),
      eventObjective: _descriptionController.text.trim(),
      eventLocation: _locationController.text.trim(),
      address: _addressController.text.trim(),
      startDate: startDateTime,
      endDate: endDateTime,
      registrationStart: startDateTime,
      registrationEnd: endDateTime,
      careerIds: _selectedCareers,
      targetTeachers: _allowProfessors,
      targetStudents: _allowStudents,
      targetAdministrative: _allowGraduates,
      targetGeneral: _allowGeneralPublic,
      isVirtual: _isVirtual,
      meetingUrl: _linkController.text.trim().isEmpty
          ? null
          : _linkController.text.trim(),
      maxCapacity: 0,
      requiresRegistration: _requiresRegistration,
      isPublic: true,
      tags: [],
      imageUrls: imageUrls,
      additionalDetails: null,
    );

    final controller = ref.read(registerEventControllerProvider.notifier);
    await controller.registerEvent(eventRequest);
  }

  void _showSuccessAndNavigate() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Evento creado exitosamente!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Limpiar el estado de éxito
    ref.read(registerEventControllerProvider.notifier).resetSuccess();

    // Navegar después de un pequeño delay para que se vea el mensaje
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );

    // Limpiar el error después de mostrarlo
    Future.delayed(const Duration(seconds: 3), () {
      ref.read(registerEventControllerProvider.notifier).clearError();
    });
  }
}
