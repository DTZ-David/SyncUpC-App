import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../design_system/atoms/primary_button.dart';
import '../../../features/forum/models/forum_request_model.dart';
import '../../../features/forum/providers/forum_providers.dart';
import '../../../utils/popup_utils.dart';
import '../widgets/content_field_section.dart';
import '../widgets/title_field_section.dart';

class CreateTopicScreen extends ConsumerStatefulWidget {
  final String eventId;
  const CreateTopicScreen(this.eventId, {super.key});

  @override
  ConsumerState<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends ConsumerState<CreateTopicScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(context),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const UserInfoSection(),
                    const SizedBox(height: 20),
                    TitleFieldSection(controller: _titleController),
                    const SizedBox(height: 16),
                    ContentFieldSection(controller: _contentController),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: "Crear Tópico",
                      variant: ButtonVariant.filled,
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;

                        final title = _titleController.text.trim();
                        final content = _contentController.text.trim();
                        final eventId = widget.eventId;
                        final request = ForumRequest(
                          eventId: eventId,
                          title: title,
                          content: content,
                        );

                        try {
                          await ref
                              .read(registerForumTopicProvider(request).future);
                          ref.invalidate(getalltopicsforeventProvider);
                          if (mounted) {
                            PopupUtils.showSuccess(
                              context,
                              message: 'Topico creado exitosamente!',
                              subtitle: 'Tu evento ha sido actualizado',
                              duration: const Duration(seconds: 2),
                            );
                          }
                          context.pop();
                        } catch (e) {
                          if (mounted) {
                            PopupUtils.showError(
                              context,
                              message: e.toString(),
                              subtitle: 'Intenta mas tarde',
                              duration: const Duration(seconds: 2),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Crea un nuevo tema",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Sección de información del usuario


