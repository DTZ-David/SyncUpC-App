import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/features/forum/models/comment_request_model.dart';
import 'package:syncupc/features/forum/providers/forum_providers.dart';

import '../../../design_system/atoms/text_field.dart';
import '../../../features/auth/providers/auth_providers.dart';
import '../../../utils/popup_utils.dart';

class ReplyInputField extends ConsumerWidget {
  final String forumId;
  const ReplyInputField(this.forumId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final _contentController = TextEditingController();

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
                hintText: "Deja tu comentario", controller: _contentController),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: AppColors.white, size: 20),
              onPressed: () async {
                final content = _contentController.text.trim();

                final request =
                    CommentRequest(forumId: forumId, content: content);

                try {
                  await ref.read(addcommentProvider(request).future);
                  PopupUtils.showSuccess(
                    context,
                    message: 'Ya mandamos tu comentario!',
                    duration: const Duration(seconds: 2),
                  );
                } catch (e) {
                  PopupUtils.showError(
                    context,
                    message: e.toString(),
                    subtitle: 'Intenta mas tarde',
                    duration: const Duration(seconds: 2),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
