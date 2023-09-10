import 'package:flutter/material.dart';

/// Widget that will check password strength and display validation messages
class PasswordStrengthChecker extends StatefulWidget {
  const PasswordStrengthChecker({
    super.key,
    required this.value,
    required this.onStrengthChanged,
  });

  /// Password value: obtained from a text field, passed to this widget
  final String value;

  /// Callback that will be called when password strength changes
  final Function(bool isStrong) onStrengthChanged;

  @override
  State<PasswordStrengthChecker> createState() =>
      _PasswordStrengthCheckerState();
}

class _PasswordStrengthCheckerState extends State<PasswordStrengthChecker> {
  /// Override didUpdateWidget to re-validate password strength when the value
  /// changes in the parent widget
  @override
  void didUpdateWidget(covariant PasswordStrengthChecker oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Check if the password value has changed
    if (widget.value != oldWidget.value) {
      /// If changed, re-validate the password strength
      final isStrong = _validators.entries.every(
        (entry) => entry.key.hasMatch(widget.value),
      );

      /// Call callback with new value to notify parent widget
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onStrengthChanged(isStrong),
      );
    }
  }

  /// Map of validators to be used to validate the password.
  ///
  /// Key: RegExp to check if the password contains a certain character type
  /// Value: Validation message to be displayed
  ///
  /// Note: You can add, remove, or change validators as per your requirements
  /// and if you are not good with RegExp, (most of us aren't), you can get help
  /// from Bard or ChatGPT to generate RegExp and validation messages.
  final Map<RegExp, String> _validators = {
    RegExp(r'[A-Z]'): 'One uppercase letter',
    RegExp(r'[!@#\$%^&*(),.?":{}|<>]'): 'One special character',
    RegExp(r'\d'): 'One number',
    RegExp(r'^.{8,32}$'): '8-32 characters',
  };

  @override
  Widget build(BuildContext context) {
    /// If the password is empty yet, we'll show validation messages in plain
    /// color, not green or red
    final hasValue = widget.value.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _validators.entries.map(
        (entry) {
          /// Check if the password matches the current validator requirement
          final hasMatch = entry.key.hasMatch(widget.value);

          /// Based on the match, we'll show the validation message in green or
          /// red color
          final color =
              hasValue ? (hasMatch ? Colors.green : Colors.red) : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              entry.value,
              style: TextStyle(color: color),
            ),
          );
        },
      ).toList(),
    );
  }
}
