// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:syncupc/ui/registerEvent/widgets/register_event_exports.dart';

class RegisterEventScreen extends ConsumerStatefulWidget {
  const RegisterEventScreen({super.key});

  @override
  ConsumerState<RegisterEventScreen> createState() =>
      _RegisterEventScreenState();
}

class _RegisterEventScreenState extends ConsumerState<RegisterEventScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissions = ref.watch(permissionProvider);
    final permissionNotifier = ref.read(permissionProvider.notifier);

    String? _startTime = '9:00 AM';
    String? _endTime = '10:00 AM';

    final List<String> _timeOptions = [
      '8:00 AM',
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '12:00 PM',
      '1:00 PM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM',
      '5:00 PM',
      '6:00 PM',
      '7:00 PM',
    ];

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
          child: AppText.heading1("Registro de eventos"),
        ),
        _buildSectionTitle("Agrega fotos del evento"),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : Center(
                    child: SvgPicture.asset('assets/images/camera.svg',
                        height: 32)),
          ),
        ),
        _buildSectionTitle("Titulo del evento"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppTextField(
            hintText: "Escribe aqui",
          ),
        ),
        _buildSectionTitle("Selecciona la fecha"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () async {
              // final pickedDate = await showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime(2000),
              //   lastDate: DateTime(2100),
              //   locale: const Locale('es', ''),
              // );
            },
            child: AbsorbPointer(
              child: AppTextField(
                hintText: "Fecha",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/images/calendar_event.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.neutral800,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildSectionTitle("Selecciona la hora"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              TimeDropdown(
                value: _startTime,
                items: _timeOptions,
                onChanged: (value) {
                  setState(() => _startTime = value);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: AppText.body2("A"),
              ),
              TimeDropdown(
                value: _endTime,
                items: _timeOptions,
                onChanged: (value) {
                  setState(() => _endTime = value);
                },
              ),
            ],
          ),
        ),
        _buildSectionTitle("Descripción del evento"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppTextField(
            hintText: "Describe el evento...",
            maxLines: 6,
            keyboardType: TextInputType.multiline,
          ),
        ),
        _buildSectionTitle("Permisos"),
        _buildSwitch(
          context,
          value: permissions.foro,
          label: "Permitir el foro",
          onChanged: permissionNotifier.toggleForo,
        ),
        _buildSwitch(
          context,
          value: permissions.compartir,
          label: "Permitir compartir",
          onChanged: permissionNotifier.toggleCompartir,
        ),
        _buildSwitch(
          context,
          value: permissions.favoritos,
          label: "Permitir agregar favoritos",
          onChanged: permissionNotifier.toggleFavoritos,
        ),
        _buildSwitch(
          context,
          value: permissions.confirmar,
          label: "Solicitar confirmar entrada/salida",
          onChanged: permissionNotifier.toggleConfirmar,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: PrimaryButton(
            text: "Crear Evento",
            variant: ButtonVariant.filled,
            onPressed: () {},
          ),
        )
      ])),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: AppText(
          title,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch(
    BuildContext context, {
    required bool value,
    required String label,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AppText.body1(
              label,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary200,
          ),
        ],
      ),
    );
  }
}
