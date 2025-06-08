import 'package:flutter/foundation.dart';
import 'package:starwars/models/payload_people.dart';
import 'package:starwars/services/sw_api.dart';

class PeopleProvider with ChangeNotifier {
  final SwApi _swApi;

  PeopleProvider(this._swApi);

  List<Person> _people = [];
  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoading = false;
  bool _initialLoading = true;
  String? _errorMessage;

  // Getters
  List<Person> get people => _people;
  bool get isLoading => _isLoading;
  bool get initialLoading => _initialLoading;
  bool get hasNextPage => _hasNextPage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPeople({bool isRefresh = false}) async {
    if (isRefresh) {
      _people = [];
      _currentPage = 1;
      _hasNextPage = true;
      _errorMessage = null;
      _initialLoading = true;
    }

    if (_isLoading || !_hasNextPage && !isRefresh) return;

    _isLoading = true;
    if (_people.isEmpty) {
      _initialLoading = true;
    }
    notifyListeners();

    try {
      final data = await _swApi.getData('people', _currentPage);
      final payload = payloadFromJson(data);

      _people.addAll(payload.results);
      _hasNextPage = payload.next != null;
      if (_hasNextPage) {
        _currentPage++;
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _initialLoading = false;
      notifyListeners();
    }
  }
}
