import 'package:baithuzakath_app/controllers/api_service_controller/scheme_service_controller.dart';
import 'package:baithuzakath_app/models/scheme_model.dart';
import 'package:flutter/foundation.dart';

class SchemeProvider extends ChangeNotifier {
  final SchemeApiService _apiService = SchemeApiService();

  List<SchemeResponse> _schemes = [];
  SchemeResponse? _selectedScheme;
  bool _isLoading = false;
  String? _errorMessage;

  // Pagination properties
  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMoreData = true;

  // Getters
  List<SchemeResponse> get schemes => _schemes;
  SchemeResponse? get selectedScheme => _selectedScheme;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMoreData => _hasMoreData;
  int get currentPage => _currentPage;

  // Fetch all schemes with optional filters
  Future<void> fetchSchemes({
    String? category,
    int? page,
    int? limit,
    bool refresh = false,
  }) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _schemes = [];
      _hasMoreData = true;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedSchemes = await _apiService.getAllSchemes(
        category: category,
        page: page ?? _currentPage,
        limit: limit ?? _limit,
      );

      if (refresh) {
        _schemes = fetchedSchemes;
      } else {
        _schemes.addAll(fetchedSchemes);
      }

      // Check if there's more data
      if (fetchedSchemes.length < (limit ?? _limit)) {
        _hasMoreData = false;
      } else {
        _currentPage++;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch scheme by ID
  Future<void> fetchSchemeById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedScheme = await _apiService.getSchemeById(id);
    } catch (e) {
      _errorMessage = e.toString();
      _selectedScheme = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load more schemes (for pagination)
  Future<void> loadMoreSchemes({String? category}) async {
    if (_hasMoreData && !_isLoading) {
      await fetchSchemes(category: category);
    }
  }

  // Refresh schemes list
  Future<void> refreshSchemes({String? category}) async {
    await fetchSchemes(category: category, refresh: true);
  }

  // Filter schemes by category
  Future<void> filterByCategory(String category) async {
    await fetchSchemes(category: category, refresh: true);
  }

  // Clear selected scheme
  void clearSelectedScheme() {
    _selectedScheme = null;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Reset provider state
  void reset() {
    _schemes = [];
    _selectedScheme = null;
    _isLoading = false;
    _errorMessage = null;
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }
}
