class SchemeResponse {
  final bool success;
  final String message;
  final SchemeData data;

  SchemeResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SchemeResponse.fromJson(Map<String, dynamic> json) {
    return SchemeResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SchemeData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class SchemeData {
  final Scheme scheme;

  SchemeData({required this.scheme});

  factory SchemeData.fromJson(Map<String, dynamic> json) {
    return SchemeData(scheme: Scheme.fromJson(json['scheme'] ?? {}));
  }

  Map<String, dynamic> toJson() {
    return {'scheme': scheme.toJson()};
  }
}

class Scheme {
  final String id;
  final String name;
  final String description;
  final String category;
  final Benefits benefits;
  final Eligibility eligibility;
  final FormConfiguration formConfiguration;
  final bool canApply;
  final bool hasApplied;
  final int daysRemaining;

  Scheme({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.benefits,
    required this.eligibility,
    required this.formConfiguration,
    required this.canApply,
    required this.hasApplied,
    required this.daysRemaining,
  });

  factory Scheme.fromJson(Map<String, dynamic> json) {
    return Scheme(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      benefits: Benefits.fromJson(json['benefits'] ?? {}),
      eligibility: Eligibility.fromJson(json['eligibility'] ?? {}),
      formConfiguration: FormConfiguration.fromJson(
        json['formConfiguration'] ?? {},
      ),
      canApply: json['canApply'] ?? false,
      hasApplied: json['hasApplied'] ?? false,
      daysRemaining: json['daysRemaining'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'category': category,
      'benefits': benefits.toJson(),
      'eligibility': eligibility.toJson(),
      'formConfiguration': formConfiguration.toJson(),
      'canApply': canApply,
      'hasApplied': hasApplied,
      'daysRemaining': daysRemaining,
    };
  }
}

class Benefits {
  final int amount;
  final String type;
  final String description;

  Benefits({
    required this.amount,
    required this.type,
    required this.description,
  });

  factory Benefits.fromJson(Map<String, dynamic> json) {
    return Benefits(
      amount: json['amount'] ?? 0,
      type: json['type'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'type': type, 'description': description};
  }
}

class Eligibility {
  final int incomeLimit;
  final AgeRange ageRange;

  Eligibility({required this.incomeLimit, required this.ageRange});

  factory Eligibility.fromJson(Map<String, dynamic> json) {
    return Eligibility(
      incomeLimit: json['incomeLimit'] ?? 0,
      ageRange: AgeRange.fromJson(json['ageRange'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'incomeLimit': incomeLimit, 'ageRange': ageRange.toJson()};
  }
}

class AgeRange {
  final int min;
  final int max;

  AgeRange({required this.min, required this.max});

  factory AgeRange.fromJson(Map<String, dynamic> json) {
    return AgeRange(min: json['min'] ?? 0, max: json['max'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'min': min, 'max': max};
  }
}

class FormConfiguration {
  final String title;
  final String description;
  final List<FormPage> pages;
  final String confirmationMessage;

  FormConfiguration({
    required this.title,
    required this.description,
    required this.pages,
    required this.confirmationMessage,
  });

  factory FormConfiguration.fromJson(Map<String, dynamic> json) {
    return FormConfiguration(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      pages:
          (json['pages'] as List<dynamic>?)
              ?.map((page) => FormPage.fromJson(page))
              .toList() ??
          [],
      confirmationMessage: json['confirmationMessage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'pages': pages.map((page) => page.toJson()).toList(),
      'confirmationMessage': confirmationMessage,
    };
  }
}

class FormPage {
  final String title;
  final List<FormField> fields;

  FormPage({required this.title, required this.fields});

  factory FormPage.fromJson(Map<String, dynamic> json) {
    return FormPage(
      title: json['title'] ?? '',
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((field) => FormField.fromJson(field))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'fields': fields.map((field) => field.toJson()).toList(),
    };
  }
}

class FormField {
  final String id;
  final String label;
  final String type;
  final bool required;
  final FieldValidation? validation;
  final List<FieldOption>? options;

  FormField({
    required this.id,
    required this.label,
    required this.type,
    required this.required,
    this.validation,
    this.options,
  });

  factory FormField.fromJson(Map<String, dynamic> json) {
    return FormField(
      id: json['id'] ?? '',
      label: json['label'] ?? '',
      type: json['type'] ?? '',
      required: json['required'] ?? false,
      validation: json['validation'] != null
          ? FieldValidation.fromJson(json['validation'])
          : null,
      options: json['options'] != null
          ? (json['options'] as List<dynamic>)
                .map((option) => FieldOption.fromJson(option))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'type': type,
      'required': required,
      if (validation != null) 'validation': validation!.toJson(),
      if (options != null)
        'options': options!.map((option) => option.toJson()).toList(),
    };
  }
}

class FieldValidation {
  final int? minLength;
  final int? maxLength;
  final int? min;
  final int? max;

  FieldValidation({this.minLength, this.maxLength, this.min, this.max});

  factory FieldValidation.fromJson(Map<String, dynamic> json) {
    return FieldValidation(
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      min: json['min'],
      max: json['max'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (minLength != null) 'minLength': minLength,
      if (maxLength != null) 'maxLength': maxLength,
      if (min != null) 'min': min,
      if (max != null) 'max': max,
    };
  }
}

class FieldOption {
  final String value;
  final String label;

  FieldOption({required this.value, required this.label});

  factory FieldOption.fromJson(Map<String, dynamic> json) {
    return FieldOption(value: json['value'] ?? '', label: json['label'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'label': label};
  }
}
