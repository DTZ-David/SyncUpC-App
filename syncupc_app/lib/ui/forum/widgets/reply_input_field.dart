import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/features/forum/models/comment_request_model.dart';
import 'package:syncupc/features/forum/providers/forum_providers.dart';

import '../../../design_system/atoms/text_field.dart';
import '../../../features/auth/providers/auth_providers.dart';
import '../../../utils/popup_utils.dart';

class ReplyInputField extends ConsumerStatefulWidget {
  final String forumId;
  const ReplyInputField(this.forumId, {super.key});

  @override
  ConsumerState<ReplyInputField> createState() => _ReplyInputFieldState();
}

class _ReplyInputFieldState extends ConsumerState<ReplyInputField> {
  late final TextEditingController contentController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(user!.photo),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppTextField(
              hintText: "Deja tu comentario",
              controller: contentController,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    )
                  : const Icon(Icons.send, color: AppColors.white, size: 20),
              onPressed: isLoading
                  ? null
                  : () async {
                      final content = contentController.text.trim();
                      if (content.isEmpty) return;

                      setState(() {
                        isLoading = true;
                      });

                      final request = CommentRequest(
                          forumId: widget.forumId, content: content);

                      try {
                        await ref.read(addcommentProvider(request).future);

                        contentController.clear();

                        // Invalidar AMBOS providers para actualizar tanto la lista como el detalle
                        ref.invalidate(getalltopicsforeventProvider);
                        ref.invalidate(getForumByIdProvider(
                            widget.forumId)); // ESTE ES EL IMPORTANTE

                        if (mounted) {
                          PopupUtils.showSuccess(
                            context,
                            message: 'Ya mandamos tu comentario!',
                            duration: const Duration(seconds: 2),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          PopupUtils.showError(
                            context,
                            message: e.toString(),
                            subtitle: 'Intenta mas tarde',
                            duration: const Duration(seconds: 2),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
