// widgets/event_image_picker.dart
import 'register_event_exports.dart';

class EventImagePicker extends StatelessWidget {
  final File? selectedImage;
  final Function(File?) onImageSelected;

  const EventImagePicker({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle("Agrega fotos del evento"),
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
            child: selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : Center(
                    child: SvgPicture.asset(
                      'assets/images/camera.svg',
                      height: 32,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
