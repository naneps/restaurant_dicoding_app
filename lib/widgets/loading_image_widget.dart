import 'package:flutter/material.dart';

class LoadingImageWidget extends StatefulWidget {
  final Size size;
  const LoadingImageWidget({super.key, this.size = const Size(100, 100)});

  @override
  State<LoadingImageWidget> createState() => _LoadingImageWidgetState();
}

class _LoadingImageWidgetState extends State<LoadingImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ShaderMask(
                blendMode: BlendMode.modulate,
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(
                      _controller.value * 2 * 3.141592653589793,
                    ),
                  ).createShader(bounds);
                },
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.image_outlined,
              size: 50,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..repeat(reverse: true);

    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(_controller);
  }
}
