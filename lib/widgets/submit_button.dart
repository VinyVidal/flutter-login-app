import 'package:flutter/material.dart';
import 'package:login/styles/text_styles.dart';
import 'package:login/widgets/loading_widget.dart';

class SubmitButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final bool isLoading;

  const SubmitButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? const LoadingWidget(
                  color: Colors.white,
                )
              : Text(
                  label,
                  style: TextStyles.buttonText,
                ),
        ),
      ),
    );
  }
}
