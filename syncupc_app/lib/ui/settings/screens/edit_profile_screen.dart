import 'package:syncupc/ui/registerEvent/widgets/register_event_exports.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _nameController = TextEditingController(text: "David Damian");
  final _usernameController = TextEditingController(text: "@daviddamian32");
  final _emailController = TextEditingController(text: "daviddamian@gmail.com");
  final _bioController = TextEditingController(text: "3013865117");

  bool _hasChanges = false;
  File? _profileImage;

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

  void _checkChanges() {
    setState(() {
      _hasChanges = _nameController.text != "David Damian" ||
          _usernameController.text != "@daviddamian32" ||
          _emailController.text != "daviddamian@gmail.com" ||
          _bioController.text != "3013865117";
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkChanges);
    _usernameController.addListener(_checkChanges);
    _emailController.addListener(_checkChanges);
    _bioController.addListener(_checkChanges);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.body2(label),
          const SizedBox(height: 4),
          AppTextField(controller: controller),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar perfil")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _pickProfileImage,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.neutral200,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? SvgPicture.asset('assets/images/camera.svg',
                              height: 32)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppText.body2("Acerca de ti", color: AppColors.neutral700),
                  const SizedBox(height: 16),
                  _buildField("Nombre", _nameController),
                  _buildField("Usuario", _usernameController),
                  _buildField("Email", _emailController),
                  _buildField("Numero", _bioController),
                ],
              ),
            ),
          ),
          if (_hasChanges)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: PrimaryButton(
                variant: ButtonVariant.filled,
                text: "Actualizar",
                onPressed: () {
                  // Aquí puedes llamar al método que actualiza la info
                  // Luego ocultar el botón:
                  setState(() {
                    _hasChanges = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
