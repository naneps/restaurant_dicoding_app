import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/models/restaurant.model.dart';
import 'package:restaurant_dicoding_app/providers/restaurant.provider.dart';

class FieldReview extends StatefulWidget {
  final RestaurantModel restaurant;

  const FieldReview({
    super.key,
    required this.restaurant,
  });

  @override
  _FieldReviewState createState() => _FieldReviewState();
}

class _FieldReviewState extends State<FieldReview>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, provider, child) {
      return Form(
        key: provider.formKey,
        child: TextFormField(
          maxLines: 4,
          controller: provider.reviewController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Write your review',
            constraints: const BoxConstraints(minHeight: 50),
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: provider.isSendingReview
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  : IconButton(
                      key: const ValueKey('send'),
                      padding: const EdgeInsets.all(0),
                      icon: Icon(Icons.send,
                          color: Theme.of(context).colorScheme.primary),
                      onPressed: () async {
                        if (provider.formKey.currentState!.validate()) {
                          await provider.addReview(id: widget.restaurant.id!);
                          provider.reviewController.clear();
                          _controller.reverse();
                        }
                      },
                    ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Review cannot be empty';
            }
            return null;
          },
        ),
      );
    });
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
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    )..forward();
  }
}
