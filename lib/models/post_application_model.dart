class PostApplicationModel {
  final String schemeId;
  final Map<String, dynamic> formData;
  final List<ApplicationDocument> documents;

  PostApplicationModel({
    required this.schemeId,
    required this.formData,
    required this.documents,
  });

  factory PostApplicationModel.fromJson(Map<String, dynamic> json) {
    return PostApplicationModel(
      schemeId: json['schemeId'] ?? '',
      formData: json['formData'] ?? {},
      documents: json['documents'] != null
          ? (json['documents'] as List)
                .map((doc) => ApplicationDocument.fromJson(doc))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schemeId': schemeId,
      'formData': formData,
      'documents': documents.map((doc) => doc.toJson()).toList(),
    };
  }

  // Helper method to add a form field
  PostApplicationModel addFormField(String key, dynamic value) {
    final updatedFormData = Map<String, dynamic>.from(formData);
    updatedFormData[key] = value;
    return PostApplicationModel(
      schemeId: schemeId,
      formData: updatedFormData,
      documents: documents,
    );
  }

  // Helper method to add a document
  PostApplicationModel addDocument(ApplicationDocument document) {
    return PostApplicationModel(
      schemeId: schemeId,
      formData: formData,
      documents: [...documents, document],
    );
  }

  // Helper method to remove a document by type
  PostApplicationModel removeDocument(String type) {
    return PostApplicationModel(
      schemeId: schemeId,
      formData: formData,
      documents: documents.where((doc) => doc.type != type).toList(),
    );
  }

  // Validate if required fields are present
  bool isValid() {
    return schemeId.isNotEmpty && formData.isNotEmpty;
  }

  // Create a copy with updated values
  PostApplicationModel copyWith({
    String? schemeId,
    Map<String, dynamic>? formData,
    List<ApplicationDocument>? documents,
  }) {
    return PostApplicationModel(
      schemeId: schemeId ?? this.schemeId,
      formData: formData ?? this.formData,
      documents: documents ?? this.documents,
    );
  }
}

class ApplicationDocument {
  final String type;
  final String url;
  final String fileName;

  ApplicationDocument({
    required this.type,
    required this.url,
    required this.fileName,
  });

  factory ApplicationDocument.fromJson(Map<String, dynamic> json) {
    return ApplicationDocument(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      fileName: json['fileName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'url': url, 'fileName': fileName};
  }

  // Helper method to get file extension
  String getFileExtension() {
    return fileName.split('.').last.toLowerCase();
  }

  // Helper method to check if document is a PDF
  bool isPdf() {
    return getFileExtension() == 'pdf';
  }

  // Helper method to check if document is an image
  bool isImage() {
    final extension = getFileExtension();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  // Helper method to get formatted document type
  String getFormattedType() {
    return type
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  // Create a copy with updated values
  ApplicationDocument copyWith({String? type, String? url, String? fileName}) {
    return ApplicationDocument(
      type: type ?? this.type,
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApplicationDocument &&
        other.type == type &&
        other.url == url &&
        other.fileName == fileName;
  }

  @override
  int get hashCode => type.hashCode ^ url.hashCode ^ fileName.hashCode;
}

// Helper class for building PostApplicationModel
class PostApplicationModelBuilder {
  String _schemeId = '';
  final Map<String, dynamic> _formData = {};
  final List<ApplicationDocument> _documents = [];

  PostApplicationModelBuilder setSchemeId(String schemeId) {
    _schemeId = schemeId;
    return this;
  }

  PostApplicationModelBuilder addFormField(String key, dynamic value) {
    _formData[key] = value;
    return this;
  }

  PostApplicationModelBuilder addFormFields(Map<String, dynamic> fields) {
    _formData.addAll(fields);
    return this;
  }

  PostApplicationModelBuilder addDocument(ApplicationDocument document) {
    _documents.add(document);
    return this;
  }

  PostApplicationModelBuilder addDocuments(
    List<ApplicationDocument> documents,
  ) {
    _documents.addAll(documents);
    return this;
  }

  PostApplicationModelBuilder clearFormData() {
    _formData.clear();
    return this;
  }

  PostApplicationModelBuilder clearDocuments() {
    _documents.clear();
    return this;
  }

  PostApplicationModel build() {
    return PostApplicationModel(
      schemeId: _schemeId,
      formData: Map<String, dynamic>.from(_formData),
      documents: List<ApplicationDocument>.from(_documents),
    );
  }
}

// Common document types constants
class DocumentType {
  static const String aadhaar = 'aadhaar';
  static const String pan = 'pan';
  static const String incomeCertificate = 'income_certificate';
  static const String bankStatement = 'bank_statement';
  static const String photo = 'photo';
  static const String signature = 'signature';
  static const String educationCertificate = 'education_certificate';
  static const String casteCertificate = 'caste_certificate';
  static const String residenceCertificate = 'residence_certificate';
  static const String birthCertificate = 'birth_certificate';

  static List<String> get allTypes => [
    aadhaar,
    pan,
    incomeCertificate,
    bankStatement,
    photo,
    signature,
    educationCertificate,
    casteCertificate,
    residenceCertificate,
    birthCertificate,
  ];
}

// Form field keys constants (based on your example)
class FormFieldKey {
  static const String name = 'field_1';
  static const String dateOfBirth = 'field_2';
  static const String gender = 'field_3';
  static const String phone = 'field_4';
  static const String aadhaar = 'field_5';
  static const String amount = 'field_12';
}
