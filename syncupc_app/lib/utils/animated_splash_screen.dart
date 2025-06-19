import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/protons/typography.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _moveUpController;
  late Animation<Offset> _logoOffsetAnimation;

  late AnimationController _finalPositionController;
  late Animation<Offset> _logoFinalPosition;

  late AnimationController _textFadeController;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Logo sube desde abajo
    _moveUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800), // Acelerado de 2500
    );
    _logoOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 2.0), // Más abajo para hacer más dramático
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _moveUpController,
      curve: Curves.easeOutCubic, // Curva más suave
    ));

    // 2. Logo se posiciona para centrar el conjunto final
    _finalPositionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700), // Acelerado de 1000
    );
    _logoFinalPosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.6, 0), // Ajustado para coincidir con tu imagen
    ).animate(CurvedAnimation(
      parent: _finalPositionController,
      curve: Curves.easeInOutCubic,
    ));

    // 3. Texto aparece con opacidad
    _textFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), // Acelerado de 800
    );
    _textOpacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.easeIn,
    ));

    // Secuencia animaciones
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    // Espera inicial reducida
    await Future.delayed(const Duration(milliseconds: 200));

    // Logo sube
    await _moveUpController.forward();

    // Pausa más corta antes de mover a posición final
    await Future.delayed(const Duration(milliseconds: 250));

    // Movimiento simultáneo del logo y aparición del texto
    await Future.wait([
      _finalPositionController.forward(),
      _textFadeController.forward(),
    ]);

    // Pausa final reducida antes de navegar
    await Future.delayed(const Duration(milliseconds: 1000));

    if (mounted) {
      context.go('/welcome'); // Cambia a tu ruta principal
    }
  }

  @override
  void dispose() {
    _moveUpController.dispose();
    _finalPositionController.dispose();
    _textFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB9FF50),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _logoOffsetAnimation,
            _logoFinalPosition,
            _textOpacityAnimation,
          ]),
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(
                    (_logoOffsetAnimation.value.dx +
                            _logoFinalPosition.value.dx) *
                        MediaQuery.of(context).size.width *
                        0.1,
                    (_logoOffsetAnimation.value.dy +
                            _logoFinalPosition.value.dy) *
                        MediaQuery.of(context).size.height *
                        0.1,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 80,
                    width: 80,
                  ),
                ),
                SizedBox(
                  width: 6 *
                      _textOpacityAnimation
                          .value, // Espaciado reducido de 16 a 10
                ),
                Opacity(
                  opacity: _textOpacityAnimation.value,
                  child: Transform.translate(
                    offset: Offset(20 * (1 - _textOpacityAnimation.value),
                        0), // Texto viene desde la derecha
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Separador visual del tamaño del logo
                        Container(
                          width: 4,
                          height: 60, // Mismo alto que el logo
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "SyncUpC",
                          style: AppTypography.heading1.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
