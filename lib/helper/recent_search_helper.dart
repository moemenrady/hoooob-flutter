import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hoooob_app/features/home/domain/models/recent_search_model.dart';

class RecentSearchHelper {
  static const String _recentSearchesKey = 'recent_searches';
  static const int _maxRecentSearches =
      5; // Maximum number of recent searches to keep

  /// Save a recent search to SharedPreferences
  static Future<void> saveRecentSearch(RecentSearchModel search) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> recentSearches =
          prefs.getStringList(_recentSearchesKey) ?? [];

      // Convert to RecentSearchModel list
      List<RecentSearchModel> searches = recentSearches
          .map((json) => RecentSearchModel.fromJson(jsonDecode(json)))
          .toList();

      // Remove duplicate if exists (same from, to, date, passengers)
      searches.removeWhere((existing) =>
          existing.fromLocation == search.fromLocation &&
          existing.toLocation == search.toLocation &&
          existing.date == search.date &&
          existing.passengers == search.passengers);

      // Add new search at the beginning
      searches.insert(0, search);

      // Keep only the most recent searches
      if (searches.length > _maxRecentSearches) {
        searches = searches.take(_maxRecentSearches).toList();
      }

      // Convert back to JSON strings
      List<String> updatedSearches =
          searches.map((search) => jsonEncode(search.toJson())).toList();

      await prefs.setStringList(_recentSearchesKey, updatedSearches);
    } catch (e) {
      print('Error saving recent search: $e');
    }
  }

  /// Get all recent searches from SharedPreferences
  static Future<List<RecentSearchModel>> getRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> recentSearches =
          prefs.getStringList(_recentSearchesKey) ?? [];

      return recentSearches
          .map((json) => RecentSearchModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Error loading recent searches: $e');
      return [];
    }
  }

  /// Clear all recent searches
  static Future<void> clearRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_recentSearchesKey);
    } catch (e) {
      print('Error clearing recent searches: $e');
    }
  }

  /// Remove a specific recent search by ID
  static Future<void> removeRecentSearch(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> recentSearches =
          prefs.getStringList(_recentSearchesKey) ?? [];

      List<RecentSearchModel> searches = recentSearches
          .map((json) => RecentSearchModel.fromJson(jsonDecode(json)))
          .toList();

      searches.removeWhere((search) => search.id == id);

      List<String> updatedSearches =
          searches.map((search) => jsonEncode(search.toJson())).toList();

      await prefs.setStringList(_recentSearchesKey, updatedSearches);
    } catch (e) {
      print('Error removing recent search: $e');
    }
  }
}
