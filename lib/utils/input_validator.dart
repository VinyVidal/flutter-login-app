class InputValidator {
  static String? textInput({required String? value, required String fieldName, InputValidatorOptions? options}) {
    String? optionsResult = _handleOptionsValidation(value: value, fieldName: fieldName, options: options);

    if (optionsResult != null) {
      return optionsResult;
    }

    return null;
  }

  static String? emailAddress({required String? value, required String fieldName, InputValidatorOptions? options}) {
    String? optionsResult = _handleOptionsValidation(value: value, fieldName: fieldName, options: options);

    if (optionsResult != null) {
      return optionsResult;
    }

    if (value != null && !RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
      return 'O campo $fieldName não é um endereço de e-mail válido.';
    }

    return null;
  }

  static String? confirmation({required String? originalValue, required String? confirmationValue, required String fieldName}) {
    if(originalValue != confirmationValue) {
      return '$fieldName não coincidem.';
    }

    return null;
  }

  static String? _handleOptionsValidation({required String? value, required String fieldName, InputValidatorOptions? options}) {
    if (options?.isRequired != null && (value == null || value.isEmpty)) {
      return 'O campo $fieldName é obrigatório.';
    }

    if (value == null) {
      return null;
    }

    if (options?.minLength != null && (value.length < options!.minLength!)) {
      return 'O campo $fieldName não pode ter menos que ${options.minLength} caracteres.';
    }

    if (options?.maxLength != null && (value.length > options!.maxLength!)) {
      return 'O campo $fieldName não pode ter mais que ${options.maxLength} caracteres.';
    }

    return null;
  }
}

class InputValidatorOptions {
  final bool? isRequired;
  final int? minLength;
  final int? maxLength;

  InputValidatorOptions({this.isRequired, this.minLength, this.maxLength});
}
