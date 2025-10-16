import '../register_event_exports.dart';

class Step1BasicInfo extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final File? selectedImage;
  final Function(File?) onImageSelected;
  final VoidCallback onNext;

  const Step1BasicInfo({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedImage,
    required this.onImageSelected,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: AppText.heading2(
            'Información Básica del Evento',
          ),
        ),

        EventImagePicker(
          selectedImage: selectedImage,
          onImageSelected: onImageSelected,
        ),

        SectionTitle('Título del evento *'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppTextField(
            controller: titleController,
            labelText: 'Escribe el título del evento',
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 24),

        SectionTitle('Descripción del evento *'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppTextField(
            controller: descriptionController,
            labelText: 'Describe el evento...',
            maxLines: 6,
          ),
        ),
        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              text: 'Siguiente',
              variant: ButtonVariant.filled,
              onPressed: onNext,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
