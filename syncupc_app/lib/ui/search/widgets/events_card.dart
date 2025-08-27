import 'package:flutter/material.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';

class EventsCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback? onTap;

  const EventsCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias, // Esto clipea todo
        elevation: 2, // Sombra suave
        child: Stack(
          children: [
            SizedBox(
              width: 112,
              height: 133,
              child: (imagePath != null && imagePath!.isNotEmpty)
                  ? Image.network(
                      imagePath!,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.3),
                      colorBlendMode: BlendMode.darken,
                      errorBuilder: (context, error, stackTrace) {
                        // Si la imagen no carga, muestro un contenedor de color
                        return Container(
                          width: 112,
                          height: 133,
                          color: const Color(0xFFA8D5BA), // verde pastel suave
                        );
                      },
                    )
                  : Container(
                      width: 112,
                      height: 133,
                      color: AppColors.primary600, // verde pastel
                    ),
            ),
            SizedBox(
              width: 112,
              height: 133,
              child: Center(
                child: AppText(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
